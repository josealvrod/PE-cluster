#!/bin/bash

set -e

PATH=/opt/puppetlabs/puppet/bin/:$PATH

puppet agent --test
