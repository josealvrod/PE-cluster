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


rm -rf /etc/puppetlabs/puppet/ssl/*

rm -f /opt/puppetlabs/puppet/cache/client_data/catalog/master1.ola.vagrant.json

puppet cert list -a

puppet cert generate master1.ola.vagrant --dns_alt_names=haproxy,master1,master2,haproxy.ola.vagrant,master1.ola.vagrant,master2.ola.vagrant

puppet cert generate pe-internal-classifier
puppet cert generate pe-internal-dashboard
puppet cert generate pe-internal-mcollective-servers
puppet cert generate pe-internal-peadmin-mcollective-client
puppet cert generate pe-internal-puppet-console-mcollective-client
puppet cert generate pe-internal-orchestrator

cp /etc/puppetlabs/puppet/ssl/ca/ca_crl.pem /etc/puppetlabs/puppet/ssl/crl.pem
chown -R pe-puppet:pe-puppet /etc/puppetlabs/puppet/ssl

rm -rf /etc/puppetlabs/puppetdb/ssl/*

cp /etc/puppetlabs/puppet/ssl/certs/master1.ola.vagrant.pem /etc/puppetlabs/puppetdb/ssl/master1.ola.vagrant.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/master1.ola.vagrant.pem /etc/puppetlabs/puppetdb/ssl/master1.ola.vagrant.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/master1.ola.vagrant.pem /etc/puppetlabs/puppetdb/ssl/master1.ola.vagrant.private_key.pem

cd /etc/puppetlabs/puppetdb/ssl
openssl pkcs8 -topk8 -inform PEM -outform DER -in /etc/puppetlabs/puppetdb/ssl/master1.ola.vagrant.private_key.pem -out /etc/puppetlabs/puppetdb/ssl/master1.ola.vagrant.private_key.pk8 -nocrypt
chown -R pe-puppetdb:pe-puppetdb /etc/puppetlabs/puppetdb/ssl

rm -rf /etc/puppetlabs/orchestration-services/ssl/*

cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.private_key.pem

cp /etc/puppetlabs/puppet/ssl/certs/master1.ola.vagrant.pem /etc/puppetlabs/orchestration-services/ssl/master1.ola.vagrant.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/master1.ola.vagrant.pem /etc/puppetlabs/orchestration-services/ssl/master1.ola.vagrant.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/master1.ola.vagrant.pem /etc/puppetlabs/orchestration-services/ssl/master1.ola.vagrant.private_key.pem

cd /etc/puppetlabs/orchestration-services/ssl
openssl pkcs8 -topk8 -inform PEM -outform DER -in /etc/puppetlabs/orchestration-services/ssl/master1.ola.vagrant.private_key.pem -out /etc/puppetlabs/orchestration-services/ssl/master1.ola.vagrant.private_key.pk8 -nocrypt
chown -R pe-orchestration-services:pe-orchestration-services /etc/puppetlabs/orchestration-services/ssl/

rm -rf /opt/puppetlabs/server/data/console-services/certs/*

cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.private_key.pem

cp /etc/puppetlabs/puppet/ssl/certs/master1.ola.vagrant.pem /opt/puppetlabs/server/data/console-services/certs/master1.ola.vagrant.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/master1.ola.vagrant.pem /opt/puppetlabs/server/data/console-services/certs/master1.ola.vagrant.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/master1.ola.vagrant.pem /opt/puppetlabs/server/data/console-services/certs/master1.ola.vagrant.private_key.pem

cd /opt/puppetlabs/server/data/console-services/certs
openssl pkcs8 -topk8 -inform PEM -outform DER -in /opt/puppetlabs/server/data/console-services/certs/master1.ola.vagrant.private_key.pem -out /opt/puppetlabs/server/data/console-services/certs/master1.ola.vagrant.private_key.pk8 -nocrypt
chown -R pe-console-services:pe-console-services /opt/puppetlabs/server/data/console-services/certs/

cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.cert.pem
cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.public_key.pem
cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.private_key.pem

chown -R pe-console-services:pe-console-services /opt/puppetlabs/server/data/console-services/certs

puppet resource service pe-puppetserver ensure=running
puppet resource service pe-puppetdb ensure=running
puppet resource service pe-console-services ensure=running
puppet resource service pe-nginx ensure=running
puppet resource service pe-activemq ensure=running
puppet resource service mcollective ensure=running
puppet resource service puppet ensure=running
puppet resource service pe-orchestration-services ensure=running
puppet resource service pxp-agent ensure=running