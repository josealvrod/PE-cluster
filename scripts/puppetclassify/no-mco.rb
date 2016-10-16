#! /opt/puppetlabs/puppet/bin/ruby
require 'puppetclassify'

fqdn = ARGV[0]

auth_info = {
  "ca_certificate_path" => "/etc/puppetlabs/puppet/ssl/certs/ca.pem",
  "certificate_path"    => "/etc/puppetlabs/puppet/ssl/certs/#{fqdn}.pem",
  "private_key_path"    => "/etc/puppetlabs/puppet/ssl/private_keys/#{fqdn}.pem",
  "read_timeout"        => 90 # optional timeout, defaults to 90 if this key doesn't exist
}

classifier_url = "https://#{fqdn}:4433/classifier-api"
puppetclassify = PuppetClassify.new(classifier_url, auth_info)

mco_group_id = puppetclassify.groups.get_group_id("PE MCollective")
mq_group_id = puppetclassify.groups.get_group_id("PE ActiveMQ Broker")
master_group_id = puppetclassify.groups.get_group_id("PE Master")

puppetclassify.groups.delete_group(mco_group_id)
puppetclassify.groups.delete_group(mq_group_id)

master_group =  puppetclassify.groups.get_group(master_group_id)
master_group['classes'].delete_if { |k,v| ["puppet_enterprise::profile::master::mcollective", "puppet_enterprise::profile::mcollective::peadmin"].include?(k) }

puppetclassify.groups.delete_group(master_group_id)
puppetclassify.groups.create_group(master_group)
