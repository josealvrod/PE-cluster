#!/bin/bash

#TODO
# mirar de poner lo del ca_proxy por classifier
# desactivar orchestration services en puppet02 por error en agent con rbac whitelist (bug)
# activar codemanager y r10k
# pruebas con filesync
# montar vault y pruebas nodo
# probar el classify todo de una vez de nuevo
# balanceo nginx bien, mantenga sesion


set -e
set -x

FQDN=$(hostname -f)
CERTS_DIR='/vagrant/certs'

# DELETE AND RECREATE CA
  # Regenerate the CA
  mkdir -p /etc/puppetlabs/puppet/ssl/certs/
  mkdir -p /etc/puppetlabs/puppet/ssl/private_keys/
  chmod 0750 /etc/puppetlabs/puppet/ssl/private_keys
  mkdir -p /etc/puppetlabs/puppet/ssl/public_keys/
  mkdir -p /etc/puppetlabs/puppet/ssl/ca/
  cp -p ${CERTS_DIR}/ca.pem /etc/puppetlabs/puppet/ssl/certs/
  cp -p ${CERTS_DIR}/ca_crl.pem /etc/puppetlabs/puppet/ssl/ca/

  # Puppet master new certs
  cp -p ${CERTS_DIR}/${FQDN}.cert.pem /etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem
  cp -p ${CERTS_DIR}/${FQDN}.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/${FQDN}.pem
  cp -p ${CERTS_DIR}/${FQDN}.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/${FQDN}.pem

  # Fake mco certs
  touch /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-mcollective-servers.pem
  touch /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-peadmin-mcollective-client.pem

  # Create the certificates for PE-related services
  cp -p ${CERTS_DIR}/pe-internal-dashboard.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem
  cp -p ${CERTS_DIR}/pe-internal-dashboard.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem
  cp -p ${CERTS_DIR}/pe-internal-dashboard.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem
  cp -p ${CERTS_DIR}/pe-internal-orchestrator.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem
  cp -p ${CERTS_DIR}/pe-internal-orchestrator.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem
  cp -p ${CERTS_DIR}/pe-internal-orchestrator.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem
  cp -p ${CERTS_DIR}/pe-internal-classifier.cert.pem /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem
  cp -p ${CERTS_DIR}/pe-internal-classifier.private_key.pem /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem
  cp -p ${CERTS_DIR}/pe-internal-classifier.public_key.pem /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem
  chmod 0640 /etc/puppetlabs/puppet/ssl/private_keys/*

  # Copy the CA’s certificate revocation list (CRL) into place
  cp -p /etc/puppetlabs/puppet/ssl/ca/ca_crl.pem /etc/puppetlabs/puppet/ssl/crl.pem

# CLEAR AND REGENERATE CERTS FOR PUPPETDB
  mkdir -p /etc/puppetlabs/puppetdb/ssl

  # Copy the certs and security credentials to the PuppetDB SSL directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem /etc/puppetlabs/puppetdb/ssl/${FQDN}.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/${FQDN}.pem /etc/puppetlabs/puppetdb/ssl/${FQDN}.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/${FQDN}.pem /etc/puppetlabs/puppetdb/ssl/${FQDN}.private_key.pem

# CLEAR AND REGENERATE CERTS FOR ORCHESTRATION-SERVICES
  mkdir -p /etc/puppetlabs/orchestration-services/ssl/*

  # Copy pe-internal-orchestrator cert and security credentials to the orchestration-services cert directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-orchestrator.pem /etc/puppetlabs/orchestration-services/ssl/pe-internal-orchestrator.private_key.pem

  # Copy the PE agent cert and security credentials to the orchestration-services cert directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem /etc/puppetlabs/orchestration-services/ssl/${FQDN}.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/${FQDN}.pem /etc/puppetlabs/orchestration-services/ssl/${FQDN}.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/${FQDN}.pem /etc/puppetlabs/orchestration-services/ssl/${FQDN}.private_key.pem

# CLEAR AND REGENERATE CERTS FOR THE PE-CONSOLE
  mkdir -p /opt/puppetlabs/server/data/console-services/certs/*

  # Copy pe-internal-classifier cert and security credentials to the console-services cert directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-classifier.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-classifier.private_key.pem

  # Copy the PE agent cert and security credentials to the console-services cert directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/${FQDN}.pem /opt/puppetlabs/server/data/console-services/certs/${FQDN}.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/${FQDN}.pem /opt/puppetlabs/server/data/console-services/certs/${FQDN}.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/${FQDN}.pem /opt/puppetlabs/server/data/console-services/certs/${FQDN}.private_key.pem

  # Copy the pe-internal-dashboard cert and security credentials to the console-services cert directory
  cp -p /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.cert.pem
  cp -p /etc/puppetlabs/puppet/ssl/public_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.public_key.pem
  cp -p /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem /opt/puppetlabs/server/data/console-services/certs/pe-internal-dashboard.private_key.pem
