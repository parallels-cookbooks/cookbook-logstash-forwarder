#
# Cookbook Name:: logstash-forwarder
# Resource:: log_forward
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#
#

require 'chef/resource'

class Chef
  class Resource
    #
    class LogForward < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :log_forward
        @provider = Chef::Provider::LogForward
        @action = :create
        @allowed_actions = [:create]
        @fields = {}
      end

      def paths(arg = nil)
        set_or_return(:paths, arg, kind_of: Array, required: true)
      end

      def fields(arg = nil)
        set_or_return(:fields, arg, kind_of: Hash, required: true)
      end
    end
  end
end
