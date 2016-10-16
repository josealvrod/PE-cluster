#!/bin/bash

set -e
set -x
set -u

PATH=/opt/puppetlabs/puppet/bin/:$PATH
FQDN=$(facter fqdn)
gem install puppetclassify
/vagrant/scripts/puppetclassify/no-ca.rb ${FQDN}
cat >> /etc/puppetlabs/code/environments/production/hieradata/common.yaml << HIERA
puppet_enterprise::profile::master::enable_ca_proxy : false
HIERA
