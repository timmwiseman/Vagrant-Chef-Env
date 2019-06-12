#!/bin/bash
#chef-ws configuration


### Repo Name


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

sudo yum install -y wget ruby git vim
wget https://packages.chef.io/files/stable/chefdk/4.0.60/el/7/chefdk-4.0.60-1.el7.x86_64.rpm 
rpm -Uvh chefdk-4.0.60-1.el7.x86_64.rpm

sudo echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
sudo echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
rm chefdk-4.0.60-1.el7.x86_64.rpm

chef generate repo $CHEF_REPO --chef-license accept
mkdir -p /home/vagrant/$CHEF_REPO/.chef
touch /home/vagrant/$CHEF_REPO/.chef/knife.rb
sudo chmod -R 777 /home/vagrant/$CHEF_REPO/
sudo chmod 757 /etc/hosts
sudo echo "${CHEF_SERVER} chef-server" >> /etc/hosts
echo "current_dir = File.dirname(__FILE__)" >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
echo "log_level                 :info" >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
echo "log_location              STDOUT" >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
echo 'node_name                 "chef-ws"' >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
echo 'client_key                "/mnt/shared-chef/chef-admin.pem"' >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
echo chef_server_url           \"https://chef-server/organizations/${CHEF_ORG}\" >> /home/vagrant/chef-repo/.chef/knife.rb
echo 'cookbook_path             ["#{current_dir}/../cookbooks"]' >> /home/vagrant/$CHEF_REPO/.chef/knife.rb
cp /mnt/shared-chef/chef-admin.pem /home/vagrant/${CHEF_REPO}/.chef

(cd /home/vagrant/$CHEF_REPO/; knife ssl fetch)

