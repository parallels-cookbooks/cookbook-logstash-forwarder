#
# Cookbook Name:: lwrp_test
# Recipe:: default
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#
#

node.set['logstash-forwarder']['logstash_servers'] = ['10.10.1.1:5043']

include_recipe 'logstash-forwarder'

log_forward 'nginx' do
  paths ['/var/log/nginx/access.log', '/var/log/nginx/error.log']
  fields types: 'nginx'
end

log_forward 'syslog' do
  paths ['/var/log/messages']
  fields types: 'syslog'
end
