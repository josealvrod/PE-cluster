#!/bin/bash

set -e
set -x

sudo yum -y update
cd /tmp/master1
sudo mkdir -p /opt/puppetlabs/server/apps
sudo mv /tmp/master1/hosts /etc/
#dependencies puppet master START
sudo yum -y install pciutils
sudo yum -y install system-logos
sudo yum -y install which
sudo yum -y install libxml2
sudo yum -y install dmidecode
sudo yum -y install net-tools
sudo yum -y install curl
sudo yum -y install mailcap
sudo yum -y install libjpeg
sudo yum -y install libtool-ltdl
sudo yum -y install unixODBC
sudo yum -y install libxslt
sudo yum -y install zlib
tar xfz puppet-enterprise-2016.2.0-el-7-x86_64.tar.gz
