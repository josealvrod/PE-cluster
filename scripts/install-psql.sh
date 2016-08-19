#!/bin/bash

set -e
set -x

sudo su -
yum -y update
yum -y install gcc
yum -y install readline-devel.x86_64
yum -y install zlib-devel.x86_64
rpm -ivh /tmp/bbdd/puppet-agent-1.5.3-1.el7.x86_64.rpm
/opt/puppetlabs/bin/puppet module install npwalker-pe_external_postgresql
/opt/puppetlabs/bin/puppet apply /tmp/bbdd/postgresql_setup.pp
sed -i -e "s/max_connections = 100/max_connections = 400/g" /var/lib/pgsql/9.4/data/postgresql.conf
sudo -i -u postgres /usr/pgsql-9.4/bin/pg_ctl -m fast restart
