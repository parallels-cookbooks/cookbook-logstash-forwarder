#
# Cookbook Name:: logstash-forwarder
# Provider:: log_forward
# Author:: Kirill Kouznetsov <agon.smith@gmail.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#

provides :log_forward if defined?(provides)

use_inline_resources if defined?(use_inline_resources)

action :create do
end
