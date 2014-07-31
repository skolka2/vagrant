# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "forwarded_port", guest: 8000, host: 8000 # analytics-frontend
  config.vm.network "forwarded_port", guest: 35729, host: 35729 # live-reload
  config.vm.network "forwarded_port", guest: 5147, host: 5147 # analytics-backend
  config.vm.network "forwarded_port", guest: 5248, host: 5248 # broker client
  config.vm.network "forwarded_port", guest: 65530, host: 65530 # broker
  config.vm.network "private_network", ip: "192.168.06.66"
  #config.vm.network "public_network"
  config.vm.provision :shell, :path => "./scripts/bootstrap.sh"
  
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |provider|
    provider.memory = 1024
    provider.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    provider.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

end
