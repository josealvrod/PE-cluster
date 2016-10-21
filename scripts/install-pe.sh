#!/bin/bash

set -e
set -x
set -u

tar xfz /vagrant/files/puppet-enterprise-2016.4.0-el-7-x86_64.tar.gz -C /tmp
/tmp/puppet-enterprise-2016.4.0-el-7-x86_64/puppet-enterprise-installer -c /vagrant/files/${HOSTNAME}.conf
