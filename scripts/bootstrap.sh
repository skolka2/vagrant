#!/usr/bin/env bash
set -e 
set -x

# root's .ssh init
#[[ ! -d /root/.ssh ]] && mkdir /root/.ssh
#cp /vagrant/scripts/ssh/* /root/.ssh/
#cat /vagrant/scripts/ssh/*.pub >> /root/.ssh/authorized_keys
#chmod -R 0700 /root/.ssh

# vagrant's .ssh init
#cp /vagrant/scripts/ssh/* .ssh/
#cat /vagrant/scripts/ssh/*.pub >> .ssh/authorized_keys
#chown vagrant:vagrant .ssh/*
#chmod -R 0700 .ssh

# identity for git checkout
#ssh-add /root/.ssh/skolka
#ssh-add -l

# apt
apt-get update
apt-get install -y git curl samba screen vim # tools 
apt-get install -y build-essential imagemagick libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev default-jdk # analytics dependencies

# samba
cat /vagrant/scripts/smb >> /etc/samba/smb.conf
service smbd restart
(echo "vagrant"; echo "vagrant") | smbpasswd -a -s vagrant

# nvm
if [[ ! -d .nvm ]]; then
	git clone https://github.com/creationix/nvm.git .nvm
	echo "source $PWD/.nvm/nvm.sh" >> .bashrc
fi
source .nvm/nvm.sh
nvm install 0.10
nvm alias default 0.10

# global npm packages
npm install -g coffee-script nodemon node-inspector bower grunt-cli canvas gm node-gyp request

# checkout analytics git repos
[[ ! -d public ]] && mkdir public

# ensure ownership of vagrant's home
chown -R vagrant:vagrant .

exit

