#!/bin/bash

set -e
set -x

sed -i -e "s/\$client_certname = \$puppet_enterprise::puppet_master_host/\$client_certname = \$::clientcert/g" /opt/puppetlabs/puppet/modules/puppet_enterprise/manifests/profile/orchestrator.pp
sed -i -e "s/\$puppet_enterprise::puppet_master_host/\$::clientcert/g" /opt/puppetlabs/puppet/modules/puppet_enterprise/manifests/trapperkeeper/orchestrator.pp
