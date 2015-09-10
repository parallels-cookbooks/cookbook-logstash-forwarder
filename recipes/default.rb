#
# Cookbook Name:: logstash-forwarder
# Recipe:: default
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#
#

if platform_family?('ubuntu', 'debian')
  apt_repository 'logstashforwarder' do
    uri node['logstash-forwarder']['repo']['url']
    distribution 'stable'
    components ['main']
    key node['logstash-forwarder']['repo']['signkey']
  end
else
  yum_repository 'logstashforwarder' do
    description 'Lostash Forwarder official repo'
    baseurl node['logstash-forwarder']['repo']['url']
    gpgkey node['logstash-forwarder']['repo']['signkey']
  end
end

package 'logstash-forwarder'

ruby_block 'get log_forward resources' do
  block do
    klass = if defined?(Chef::ResourceResolver)
      r = Chef::ResourceResolver
      r.respond_to?(:resolve) && r.resolve(:logstash_forwarder)
    end
    klass ||= Chef::Resource::LogstashForwarder
    files = run_context.resource_collection.select { |r| r.is_a?(klass) }.map { |r| { paths: r.paths, fields: r.fields } }
    node.set['logstash-forwarder']['files'] = files
  end
end

if node['logstash-forwarder']['enable_ssl']
  Chef::Application.fatal!("Recipe logstash-forwarder::default can not use 'enable_ssl' with without providing ssl_cert") if node['logstash-forwarder']['ssl_cert'] == ''
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
