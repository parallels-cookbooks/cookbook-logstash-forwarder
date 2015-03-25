module LogstashForwarder
  # Helper module
  module Helpers
    def package_path
      package = node['logstash-forwarder']['package_url'] % { version: node['logstash-forwarder']['version'] }
      ::File.join('/tmp', package.split('/')[-1])
    end

    def package_url
      node['logstash-forwarder']['package_url'] % { version: node['logstash-forwarder']['version'] }
    end
  end
end

Chef::Recipe.send(:include, LogstashForwarder::Helpers)
Chef::Resource.send(:include, LogstashForwarder::Helpers)
