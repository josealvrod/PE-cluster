#!/bin/bash -xe

#Compile Master Installation
curl -k https://puppet01:8140/packages/current/install.bash | sudo bash -s main:dns_alt_names=haproxy,puppet01,puppet02,haproxy.vagrant.test,puppet01.vagrant.test,puppet02.vagrant.test

#Monolithic installation
#sudo /tmp/master/puppet-enterprise-2016.2.1-el-7-x86_64/puppet-enterprise-installer -c /tmp/master/pe2.conf
#sudo /opt/puppetlabs/puppet/bin/puppet agent -t
#sudo /vagrant/files/saved_certs.sh
#sudo /opt/puppetlabs/puppet/bin/puppet agent -t
#sudo echo "node1.ola.vagrant" >> /etc/puppetlabs/puppet/autosign.conf