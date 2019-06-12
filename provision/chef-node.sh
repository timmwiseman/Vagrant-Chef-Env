#!/bin/bash
#chef-node configuration

  if [ -z "$1" ]; then
      CHEF_REPO='chef-repo'
    else
      CHEF_REPO=$1
  fi

  if [ -z "$2" ]; then
      CHEF_SERVER='192.168.33.10'
    else
      CHEF_SERVER=$2
  fi

  if [ -z "$3" ]; then
      CHEF_ORG='chef-org'
    else
      CHEF_ORG=$3
  fi

sudo yum install -y ruby wget vim yum-utils

sudo rpm --import https://packages.chef.io/chef.asc
cat >chef-stable.repo <<EOL
[chef-stable]
name=chef-stable
baseurl=https://packages.chef.io/repos/yum/stable/el/7/\$basearch/
gpgcheck=1
enabled=1
EOL

sudo mv chef-stable.repo /etc/yum.repos.d/
sudo yum-config-manager --add-repo chef-stable.repo
sudo yum install -y chef

sudo chmod 757 /etc/hosts
sudo echo "${CHEF_SERVER} chef-server" >> /etc/hosts

sudo mkdir -p /etc/chef && sudo touch /etc/chef/client.rb
sudo mv /mnt/shared-chef/${CHEF_ORG}-validator.pem /etc/chef/ && sudo chmod 777 -R /etc/chef/

sudo echo 'log_level        :debug' >> /etc/chef/client.rb
sudo echo 'log_location     "/etc/chef/client.log"' >> /etc/chef/client.rb
sudo echo chef_server_url           \"https://chef-server/organizations/${CHEF_ORG}\" >> /etc/chef/client.rb
sudo echo validation_key \'/etc/chef/${CHEF_ORG}-validator.pem\' >> /etc/chef/client.rb
sudo echo 'ssl_verify_mode :verify_none' >> /etc/chef/client.rb

chef-client --chef-license accept-silent

sudo rm /etc/chef/${CHEF_ORG}-validator.pem

