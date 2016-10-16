#!/bin/bash

set -e

PATH=/opt/puppetlabs/puppet/bin/:$PATH

# Start PE services
puppet resource service pe-puppetserver ensure=running
puppet resource service pe-puppetdb ensure=running
puppet resource service pe-console-services ensure=running
puppet resource service pe-nginx ensure=running
puppet resource service pe-orchestration-services ensure=running
