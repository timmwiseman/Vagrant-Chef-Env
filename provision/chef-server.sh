#!/bin/bash
#chef-server configuration

  if [ -z "$1" ]; then
      CHEF_ORG='chef-org'
    else
      CHEF_ORG=$1
  fi

sudo yum install -y wget ruby
sudo wget https://packages.chef.io/files/stable/chef-server/12.19.31/el/7/chef-server-core-12.19.31-1.el7.x86_64.rpm
sudo mv chef-server-core-12.19.31-1.el7.x86_64.rpm /tmp
sudo rpm -Uvh /tmp/chef-server-core-12.19.31-1.el7.x86_64.rpm
sudo chef-server-ctl reconfigure
sudo rm -f /mnt/shared-chef/*
sudo chef-server-ctl user-create chef-admin chef admin chef-admin@foo.com 'default' --filename /mnt/shared-chef/chef-admin.pem
sudo chef-server-ctl org-create $CHEF_ORG 'Vagrant Chef Org' --association_user chef-admin --filename /mnt/shared-chef/$CHEF_ORG-validator.pem
