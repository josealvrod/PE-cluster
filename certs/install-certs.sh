#!/bin/bash

set -e
set -x

# Shut down all PE-related services
puppet resource service puppet ensure=stopped
puppet resource service pe-puppetserver ensure=stopped
puppet resource service pe-activemq ensure=stopped
puppet resource service mcollective ensure=stopped
puppet resource service pe-puppetdb ensure=stopped
#puppet resource service pe-postgresql ensure=stopped
puppet resource service pe-console-services ensure=stopped
puppet resource service pe-nginx ensure=stopped
puppet resource service pe-orchestration-services ensure=stopped
puppet resource service pxp-agent ensure=stopped

# DELETE AND RECREATE CA
  # Delete the CA and clear all certs from your master
  rm -rf /etc/puppetlabs/puppet/ssl/*

  # Remove the cached catalog
  rm -f /opt/puppetlabs/puppet/cache/client_data/catalog/puppet01.vagrant.test.json

  # Regenerate the CA
  mkdir -p /etc/puppetlabs/puppet/ssl/certs/
  mkdir -p /etc/puppetlabs/puppet/ssl/private_keys/
  mkdir -p /etc/puppetlabs/puppet/ssl/public_keys/
  mkdir -p /etc/puppetlabs/puppet/ssl/ca/
  cp ca.pem /etc/puppetlabs/puppet/ssl/certs/
  cp ca_crl.pem /etc/puppetlabs/puppet/ssl/ca/

  # Puppet master new certs
  cp puppet01.vagrant.test.cert.pem /etc/puppetlabs/puppet/ssl/certs/puppet01.vagrant.test.pem
  cp puppet01.vagrant.test.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/puppet01.vagrant.test.pem
  cp puppet01.vagrant.test.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/puppet01.vagrant.test.pem

  # Create the certificates for PE-related services
  cp pe-internal-dashboard.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem
  cp pe-internal-dashboard.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem
  cp pe-internal-dashboard.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem
  cp pe-internal-orchestrator.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem
  cp pe-internal-orchestrator.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem
  cp pe-internal-orchestrator.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem
  cp pe-internal-classifier.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem
  cp pe-internal-classifier.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem
  cp pe-internal-classifier.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem
  cp pe-internal-mcollective-servers.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-mcollective-servers.pem
  cp pe-internal-mcollective-servers.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-mcollective-servers.pem
  cp pe-internal-mcollective-servers.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-mcollective-servers.pem
  cp pe-internal-peadmin-mcollective-client.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-peadmin-mcollective-client.pem
  cp pe-internal-peadmin-mcollective-client.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-peadmin-mcollective-client.pem
  cp pe-internal-peadmin-mcollective-client.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-peadmin-mcollective-client.pem
  cp pe-internal-puppet-console-mcollective-client.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-puppet-console-mcollective-client.pem
  cp pe-internal-puppet-console-mcollective-client.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-puppet-console-mcollective-client.pem
  cp pe-internal-puppet-console-mcollective-client.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-puppet-console-mcollective-client.pem

  # Copy the CA’s certificate revocation list (CRL) into place
  cp /etc/puppetlabs/puppet/ssl/ca/ca_crl.pem /etc/puppetlabs/puppet/ssl/crl.pem
  chown -R pe-puppet:pe-puppet /etc/puppetlabs/puppet/ssl

# CLEAR AND REGENERATE CERTS FOR PUPPETDB
  # Clear the certs and security credentials from the PuppetDB SSL directory
  rm -rf /etc/puppetlabs/puppetdb/ssl/*

  # Copy the certs and security credentials to the PuppetDB SSL directory
  cp /etc/puppetlabs/puppet/ssl/certs/<CERTNAME>.pem /etc/puppetlabs/puppetdb/ssl/<CERTNAME>.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/<CERTNAME>.pem /etc/puppetlabs/puppetdb/ssl/<CERTNAME>.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/<CERTNAME>.pem /etc/puppetlabs/puppetdb/ssl/<CERTNAME>.private_key.pem

  # Create PuppetDB’s .pk8 cert
  cd /etc/puppetlabs/puppetdb/ssl
  openssl pkcs8 -topk8 -inform PEM -outform DER -in /etc/puppetlabs/puppetdb/ssl/<CERTNAME>.private_key.pem -out /etc/puppetlabs/puppetdb/ssl/<CERTNAME>.private_key.pk8 -nocrypt
  chown -R pe-puppetdb:pe-puppetdb /etc/puppetlabs/puppetdb/ssl

# CLEAR AND REGENERATE CERTS FOR ORCHESTRATION-SERVICES
  # Remove all credentials in the orchestration-services certificate directory
  rm -rf /etc/puppetlabs/orchestration-services/ssl/*

  # Copy pe-internal-orchestrator cert and security credentials to the orchestration-services cert directory
  cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.private_key.pem

  # Copy the PE agent cert and security credentials to the orchestration-services cert directory
  cp /etc/puppetlabs/puppet/ssl/certs/<CERTNAME>.pem /etc/puppetlabs/orchestration-services/ssl/<CERTNAME>.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/<CERTNAME>.pem /etc/puppetlabs/orchestration-services/ssl/<CERTNAME>.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/<CERTNAME>.pem /etc/puppetlabs/orchestration-services/ssl/<CERTNAME>.private_key.pem

  # Create the orchestration-services .pk8 cert
  cd /etc/puppetlabs/orchestration-services/ssl
  openssl pkcs8 -topk8 -inform PEM -outform DER -in /etc/puppetlabs/orchestration-services/ssl/<CERTNAME>.private_key.pem -out /etc/puppetlabs/orchestration-services/ssl/<CERTNAME>.private_key.pk8 -nocrypt
  chown -R pe-orchestration-services:pe-orchestration-services /etc/puppetlabs/orchestration-services/ssl/

# CLEAR AND REGENERATE CERTS FOR THE PE-CONSOLE
  # Remove all credentials in the console-services certificate directory
  rm -rf /opt/puppetlabs/server/data/console-services/certs/*

  # Copy pe-internal-classifier cert and security credentials to the console-services cert directory
  cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.private_key.pem

  # Copy the PE agent cert and security credentials to the console-services cert directory
  cp /etc/puppetlabs/puppet/ssl/certs/<CERTNAME>.pem /opt/puppetlabs/server/data/console-services/certs/<CERTNAME>.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/<CERTNAME>.pem /opt/puppetlabs/server/data/console-services/certs/<CERTNAME>.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/<CERTNAME>.pem /opt/puppetlabs/server/data/console-services/certs/<CERTNAME>.private_key.pem

  # Create the console-services .pk8 cert
  cd /opt/puppetlabs/server/data/console-services/certs
  openssl pkcs8 -topk8 -inform PEM -outform DER -in /opt/puppetlabs/server/data/console-services/certs/<CERTNAME>.private_key.pem -out /opt/puppetlabs/server/data/console-services/certs/<CERTNAME>.private_key.pk8 -nocrypt
  chown -R pe-console-services:pe-console-services /opt/puppetlabs/server/data/console-services/certs/

  # Copy the pe-internal-dashboard cert and security credentials to the console-services cert directory
  cp /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.cert.pem
  cp /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.public_key.pem
  cp /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.private_key.pem

  # Ensure the console can access the new credentials
  chown -R pe-console-services:pe-console-services /opt/puppetlabs/server/data/console-services/certs

# Restart PE services
puppet resource service pe-puppetserver ensure=running
#puppet resource service pe-postgresql ensure=running
puppet resource service pe-puppetdb ensure=running
puppet resource service pe-console-services ensure=running
puppet resource service pe-nginx ensure=running
puppet resource service pe-activemq ensure=running
puppet resource service mcollective ensure=running
puppet resource service puppet ensure=running
puppet resource service pe-orchestration-services ensure=running
puppet resource service pxp-agent ensure=running
