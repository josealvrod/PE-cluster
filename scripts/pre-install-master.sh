#!/bin/bash 

set -e
set -x

mkdir -p /opt/puppetlabs/server/apps

tar xfz /vagrant/files/master/puppet-enterprise-2016.2.1-el-7-x86_64.tar.gz -C /tmp
