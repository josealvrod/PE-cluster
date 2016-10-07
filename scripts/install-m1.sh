#!/bin/bash 

set -e
set -x

/tmp/puppet-enterprise-2016.2.1-el-7-x86_64/puppet-enterprise-installer -c /vagrant/files/master/pe1.conf
cd /vagrant/certs; ./install-certs.sh
