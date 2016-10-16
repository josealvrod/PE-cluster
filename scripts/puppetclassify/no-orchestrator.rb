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

orch_group_id = puppetclassify.groups.get_group_id("PE Orchestrator")

nodes = ["#{fqdn}"]

puppetclassify.groups.unpin_nodes(orch_group_id, nodes)
