# Vagrant-Chef

### Variables
**chef_org** - overrides the default name of the chef org created on the chef server

**chef_repo** - overrides the default name of the chef repo setup on the workstation

**chef_server** - overrides the default value of the chef server everything points to

#### Example usage
<vagrant up>

>chef_org=chef-test chef_repo=test repo vagrant up

>vagrant ssh chef-ws
