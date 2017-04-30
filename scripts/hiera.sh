#!/bin/bash

set -e

cat > /etc/puppetlabs/code/environments/production/hieradata/common.yaml << HIERA
---
puppet_enterprise::console_host : "haproxy.vagrant.test"
puppet_enterprise::puppetdb_host : "haproxy.vagrant.test"
puppet_enterprise::puppet_master_host : "haproxy.vagrant.test"
puppet_enterprise::pcp_broker_host : "haproxy.vagrant.test"
puppet_enterprise::profile::puppetdb::whitelisted_certnames : ["haproxy.vagrant.test","puppet01.vagrant.test","puppet02.vagrant.test"]
puppet_enterprise::profile::console::master_certname : "$(hostname -f)"
HIERA
