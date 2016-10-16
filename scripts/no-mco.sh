#!/bin/bash

set -e
set -x
set -u

PATH=/opt/puppetlabs/puppet/bin/:$PATH
FQDN=$(facter fqdn)
gem install puppetclassify
/vagrant/scripts/puppetclassify/no-mco.rb ${FQDN}
systemctl stop pe-activemq
systemctl stop mcollective
systemctl disable pe-activemq
systemctl disable mcollective
systemctl mask pe-activemq
systemctl mask mcollective
