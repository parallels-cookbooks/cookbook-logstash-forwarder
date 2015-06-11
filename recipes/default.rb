#
# Cookbook Name:: logstash-forwarder
# Recipe:: default
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#
#

remote_file package_path do
  owner 'root'
  group 'root'
  mode '0644'
  source package_url
end

if platform_family?('ubuntu', 'debian')
  dpkg_package node['logstash-forwarder']['package_name'] do
    source package_path
    action :install
  end
else
  package node['logstash-forwarder']['package_name'] do
    source package_path
    action :install
  end
end

ruby_block 'get log_forward resources' do
  block do
    files = run_context.resource_collection.select { |r| r.is_a?(Chef::Resource::LogstashForwarder) }.map { |r| { paths: r.paths, fields: r.fields } }
    node.set['logstash-forwarder']['files'] = files
  end
end

template node['logstash-forwarder']['config_path'] do
  source 'forwarder.conf.erb'
  owner 'root'
  group 'root'
  mode '0640'
  variables(:servers => node['logstash-forwarder']['logstash_servers'])
  notifies :restart, "service[#{node['logstash-forwarder']['service_name']}]"
end

service node['logstash-forwarder']['service_name'] do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
