require 'spec_helper'

describe 'logstash-forwarder::default' do

  it 'installs package' do
    expect(package('logstash-forwarder')).to be_installed.with_version('0.4.0')
  end

  context 'creates config' do
    describe file('/etc/logstash-forwarder.conf') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_mode 640 }
      its(:content) { should match(/10.10.1.1:5043/) }
      its(:content) { should match %r{"files": \[{"paths":\["/var/log/nginx/access.log","/var/log/nginx/error.log"\],"fields":{"types":"nginx"}},{"paths":\["/var/log/messages"\],"fields":{"types":"syslog"}}\]} }
    end
  end

  it 'runs and enables service' do
    expect(service('logstash-forwarder')).to be_running
    expect(service('logstash-forwarder')).to be_enabled
  end
end
