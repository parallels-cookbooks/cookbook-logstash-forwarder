# logstash-forwarder

## Description
Cookbook with LWRPs for install and managing [logstash-forwarder](https://github.com/elastic/logstash-forwarder)

## Requirements

### Platforms
- amazon 2014
- redhat 6
- centos 6
- scientific 6
- fedora 18, 19
- debian 7
- ubuntu >= 12.04

## Attributes

|Attribute|Description|Type|Default|
|---------|-----------|----|-------|
|node['logstash-forwarder']['package_name']|logstash-forwarder package name|String|logstash-forwarder|
|node['logstash-forwarder']['service_name']|logstash-forwarder service name|String|logstash-forwarder|
|node['logstash-forwarder']['logstash_servers']|List of servers, which will be used as downstream.|Array|['localhost:5043']|
|node['logstash-forwarder']['timeout']|Network timeout in seconds. This parameter will be passed to config file.|Integer|15|
|node['logstash-forwarder']['config_path']|The path to the config file|String|/etc/logstash-forwarder.conf|
|node['logstash-forwarder']['version']|logstash-forwarder package version|String|0.4.0|
|node['logstash-forwarder']['ssl_ca']|The path to trusted ssl ca certificate. Downstream servers must be signed by this cetificate.|String|platform dependent|
|node['logstash-forwarder']['enable_ssl']|Whether to enable SSL or not.|Boolean|false|
|node['logstash-forwarder']['ssl_cert']|The path to ssl certificate. Required when enable_ssl is `true`.|String|''|
|node['logstash-forwarder']['ssl_key']|The path to ssl key. Valid when enable_ssl is `true`.|String|''|
|node['logstash-forwarder']['package_url']|Url from which to load the logstash-forwarder package.|String|platform dependent|

## Resources/Providers

### log_forward
Adds information about wich files must be forwarded to remote logstash server to config file.

#### Attributes

|Attribute|Description|Type|
|---------|-----------|----|
|paths|List of files, which will be forwarded to remote logstash server|Array|
|fields|A dictionary of fields to annotate on each event.|Hash|

## Examples
You may see examples in fixture cookbook: [test/fixtures/lwrp_test/recipes/default.rb](test/fixtures/lwrp_test/recipes/default.rb)

## Authors
- Author:: Pavel Yudin (pyudin@parallels.com)
