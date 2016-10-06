#!/bin/bash -ex

sudo su -
yum -y install vim
mkdir -p /apps/psql/data
mkdir -p /apps/psql/logs
#sed -i '/search/d' /etc/resolv.conf
chmod 755 /apps/psql/*
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y puppet-agent
/opt/puppetlabs/bin/puppet module install npwalker-pe_external_postgresql
/opt/puppetlabs/bin/puppet apply /tmp/bbdd/init.pp
