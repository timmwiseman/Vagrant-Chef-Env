#-*- mode: ruby -*-
#vi: set ft=ruby :

# ******************** PLUGIN INSTALLATION ******************
#required_plugins = %W( vagrant-vbguest )
#required_plugins.each do |plugin|
#   system “vagrant plugin install #{plugin}” unless Vagrant.has_plugin? plugin
#end

Vagrant.configure("2") do |config|
config.vm.define 'chef-server' do |config|
  config.vm.box = 'centos/7'
  config.vm.hostname = 'chef-server'
# config.ssh.private_key_path = '~/.ssh/vagrant-ssh'
  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: '192.168.33.10'
  config.vm.network :public_network
  config.vm.synced_folder "./shared", "/mnt/shared-chef"
  config.vm.provision 'shell' do |s|
    s.args = ["#{ENV['chef_org']}"]
    s.path = './provision/chef-server.sh'
  end
end

config.vm.define 'chef-ws' do |config|
  config.vm.box = 'centos/7'
  config.vm.hostname = 'chef-ws'
# config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: '192.168.33.11'
  config.vm.network :public_network
  config.vm.synced_folder "./shared", "/mnt/shared-chef"
  config.vm.provision 'shell' do |s| 
   s.args = ["#{ENV['chef_repo']}", "#{ENV['chef_server']}", "#{ENV['chef_org']}"]
   s.path = './provision/chef-ws.sh'
    end
 end

config.vm.define 'chef-node' do |config|
  config.vm.box = 'centos/7'
  config.vm.hostname = 'chef-node'
# config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: '192.168.33.12'
  config.vm.network :public_network
  config.vm.synced_folder "./shared", "/mnt/shared-chef"
  config.vm.provision 'shell' do |s|
   s.args = ["#{ENV['chef_repo']}", "#{ENV['chef_server']}", "#{ENV['chef_org']}"]
   s.path = './provision/chef-node.sh'
    end
 end
end
