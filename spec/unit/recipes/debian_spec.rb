#
# Cookbook Name:: logstash-forwarder
# Spec:: debian
#
# Author:: Pavel Yudin <pyudin@parallels.com>
#
# Copyright (c) 2015, Parallels IP Holdings GmbH
#

require 'spec_helper'

describe 'lwrp_test' do
  platforms = {
    'ubuntu' => ['14.04', '12.04'],
    'debian' => ['7.0']
  }

  platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version) do |node|
            node.set['logstash-forwarder']['logstash_servers'] = ['localhost:5043']
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          chef_run
        end

        it 'creates remote_file' do
          expect(chef_run).to create_remote_file('/tmp/logstash-forwarder_0.4.0_amd64.deb')
        end

        it 'creates template' do
          expect(chef_run).to create_template('/etc/logstash-forwarder.conf')
          expect(chef_run).to render_file('/etc/logstash-forwarder.conf').with_content('["10.10.1.1:5043"]')
          expect(chef_run).to render_file('/etc/logstash-forwarder.conf').with_content('"timeout": 15')
          expect(chef_run).to render_file('/etc/logstash-forwarder.conf').with_content('"ssl ca": "/etc/ssl/certs/ca-certificates.crt"')
          expect(chef_run).to render_file('/etc/logstash-forwarder.conf').with_content('"files": []')
        end

        it 'installs package' do
          expect(chef_run).to install_dpkg_package('logstash-forwarder')
        end

        it 'enable and start service' do
          expect(chef_run).to start_service('logstash-forwarder')
          expect(chef_run).to enable_service('logstash-forwarder')
        end

        it 'should set files' do
          chef_run.find_resource(:ruby_block, 'get log_forward resources').old_run_action(:create)
          expect(chef_run.node['logstash-forwarder']['files'])
            .to eq([{ 'paths' => ['/var/log/nginx/access.log', '/var/log/nginx/error.log'], 'fields' => { 'types' => 'nginx' } }, { 'paths' => ['/var/log/messages'], 'fields' => { 'types' => 'syslog' } }])
        end

        it 'runs a ruby_block' do
          expect(chef_run).to run_ruby_block('get log_forward resources')
        end
      end
    end
  end
end
