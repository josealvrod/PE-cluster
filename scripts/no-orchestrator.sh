#!/bin/bash

set -e
set -x
set -u

PATH=/opt/puppetlabs/puppet/bin/:$PATH
FQDN=$(facter fqdn)
gem install puppetclassify
/vagrant/scripts/puppetclassify/no-orchestrator.rb ${FQDN}
systemctl stop pe-orchestration-services
systemctl disable pe-orchestration-services
systemctl mask pe-orchestration-services
