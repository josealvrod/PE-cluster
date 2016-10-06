#!/bin/bash

set -e
set -x


# Replace the PE Master and PE console certificates and security credentials
  # PE Master
mkdir -p /etc/puppetlabs/puppet/ssl/certs/
mkdir -p /etc/puppetlabs/puppet/ssl/private_keys/
mkdir -p /etc/puppetlabs/puppet/ssl/public_keys/
cp puppet01.vagrant.test.cert.pem /etc/puppetlabs/puppet/ssl/certs/puppet01.vagrant.test.pem
cp puppet01.vagrant.test.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/puppet01.vagrant.test.pem
cp puppet01.vagrant.test.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/puppet01.vagrant.test.pem
  # External CA
mkdir -p /etc/puppetlabs/puppet/ssl/ca/
cp crl.pem /etc/puppetlabs/puppet/ssl/
cp ca_crl.pem /etc/puppetlabs/puppet/ssl/ca/
cp ca.pem /etc/puppetlabs/puppet/ssl/certs/
  # PE Console
mkdir -p /opt/puppetlabs/server/data/console-services/certs/
cp pe-internal-dashboard.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem
cp pe-internal-dashboard.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem
cp pe-internal-dashboard.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem
cp pe-internal-dashboard.cert.pem pe-internal-dashboard.private_key.pem pe-internal-dashboard.public_key.pem /opt/puppetlabs/server/data/console-services/certs/

# Replace the orchestration-services certificates and security credentials
mkdir -p /etc/puppetlabs/orchestration-services/ssl/
cp pe-internal-orchestrator.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem
cp pe-internal-orchestrator.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem
cp pe-internal-orchestrator.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem
cp pe-internal-orchestrator.cert.pem pe-internal-orchestrator.private_key.pem pe-internal-orchestrator.public_key.pem /etc/puppetlabs/orchestration-services/ssl/
cp puppet01.vagrant.test.private_key.pk8 /etc/puppetlabs/orchestration-services/ssl/

# Replace the pe-internal-classifier certificate and security credentials
cp pe-internal-classifier.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem
cp pe-internal-classifier.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem
cp pe-internal-classifier.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem
cp pe-internal-classifier.cert.pem pe-internal-classifier.private_key.pem pe-internal-classifier.public_key.pem /opt/puppetlabs/server/data/console-services/certs/
cp puppet01.vagrant.test.private_key.pk8 /opt/puppetlabs/server/data/console-services/certs/

# Replace the PuppetDB certificates and security credentials
mkdir -p /etc/puppetlabs/puppetdb/ssl/
cp puppet01.vagrant.test.cert.pem puppet01.vagrant.test.private_key.pem puppet01.vagrant.test.public_key.pem /etc/puppetlabs/puppetdb/ssl/
cp puppet01.vagrant.test.private_key.pk8 /etc/puppetlabs/puppetdb/ssl/

# Replace the MCollective certificates and security credentials
cp pe-internal-mcollective-servers.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-mcollective-servers.pem
cp pe-internal-mcollective-servers.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-mcollective-servers.pem
cp pe-internal-mcollective-servers.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-mcollective-servers.pem

cp pe-internal-peadmin-mcollective-client.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-peadmin-mcollective-client.pem
cp pe-internal-peadmin-mcollective-client.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-peadmin-mcollective-client.pem
cp pe-internal-peadmin-mcollective-client.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-peadmin-mcollective-client.pem

cp pe-internal-puppet-console-mcollective-client.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-puppet-console-mcollective-client.pem
cp pe-internal-puppet-console-mcollective-client.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-puppet-console-mcollective-client.pem
cp pe-internal-puppet-console-mcollective-client.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-puppet-console-mcollective-client.pem
