#!/bin/bash -xe

puppet resource service puppet ensure=stopped
puppet resource service pe-puppetserver ensure=stopped
puppet resource service pe-activemq ensure=stopped
puppet resource service mcollective ensure=stopped
puppet resource service pe-puppetdb ensure=stopped
puppet resource service pe-console-services ensure=stopped
puppet resource service pe-nginx ensure=stopped
puppet resource service pe-orchestration-services ensure=stopped
puppet resource service pxp-agent ensure=stopped

cd /vagrant/files

tar xfpz /vagrant/files/certs.tar.gz

rm -rf /etc/puppetlabs/puppet/ssl/*
rm -f /opt/puppetlabs/puppet/cache/client_data/catalog/puppet01.vagrant.test.json
rm -rf /etc/puppetlabs/puppetdb/ssl/*
rm -rf /etc/puppetlabs/orchestration-services/ssl/*
rm -rf /opt/puppetlabs/server/data/console-services/certs/*

cp -pR /vagrant/files/certs/opt/puppetlabs/puppet/cache/client_data/catalog/* /opt/puppetlabs/puppet/cache/client_data/catalog/
cp -pR /vagrant/files/certs/etc/puppetlabs/puppet/ssl/* /etc/puppetlabs/puppet/ssl/
cp -pR /vagrant/files/certs/etc/puppetlabs/puppetdb/ssl/* /etc/puppetlabs/puppetdb/ssl/
cp -pR /vagrant/files/certs/etc/puppetlabs/orchestration-services/ssl/* /etc/puppetlabs/orchestration-services/ssl/
cp -pR /vagrant/files/certs/opt/puppetlabs/server/data/console-services/certs/* /opt/puppetlabs/server/data/console-services/certs/

puppet resource service pe-puppetserver ensure=running
puppet resource service pe-puppetdb ensure=running
puppet resource service pe-console-services ensure=running
puppet resource service pe-nginx ensure=running
puppet resource service pe-activemq ensure=running
puppet resource service mcollective ensure=running
#puppet resource service puppet ensure=running
puppet resource service pe-orchestration-services ensure=running
puppet resource service pxp-agent ensure=running