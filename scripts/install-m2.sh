#!/bin/bash

set -e
set -x

sudo /tmp/master2/puppet-enterprise-2016.2.0-el-7-x86_64/puppet-enterprise-installer -c /tmp/master2/pe.conf
#sudo /opt/puppetlabs/puppet/bin/puppet agent -t
sudo echo "node1.ola.vagrant" >> /etc/puppetlabs/puppet/autosign.conf
