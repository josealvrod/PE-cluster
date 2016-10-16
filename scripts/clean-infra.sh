#!/bin/bash

set -e
set -x
set -u

PATH=/opt/puppetlabs/puppet/bin/:$PATH
FQDN=$(facter fqdn)
gem install puppetclassify
/vagrant/scripts/puppetclassify/clean-infra.rb ${FQDN}
