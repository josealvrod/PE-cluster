#!/bin/bash -ex

sudo su -
yum -y install vim
mkdir -p /apps/psql/data
mkdir -p /apps/psql/logs
#sed -i '/search/d' /etc/resolv.conf
chmod 666 /apps/psql/*
rpm -ivh /tmp/bbdd/puppet-agent-1.5.3-1.el7.x86_64.rpm
/opt/puppetlabs/bin/puppet module install npwalker-pe_external_postgresql
/opt/puppetlabs/bin/puppet apply /tmp/bbdd/init.pp