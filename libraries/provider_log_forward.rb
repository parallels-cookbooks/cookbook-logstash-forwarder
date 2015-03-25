#
# Cookbook Name:: logstash-forwarder
# Provider:: log_forward
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#
#

require 'chef/provider'

class Chef
  class Provider
    #
    class LogForward < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def action_create
      end
    end
  end
end
