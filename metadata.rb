name             'logstash-forwarder'
maintainer       'Pavel Yudin'
maintainer_email 'pyudin@parallels.com'
license          'Apache 2.0'
description      'Installs and configures logstash-forwarder'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.4'

supports 'amazon'
supports 'redhat'
supports 'centos'
supports 'scientific'
supports 'fedora'
supports 'debian'
supports 'ubuntu'

depends 'apt'
depends 'yum'
