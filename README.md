### WARNING
Please after your vagrant VM is ready install manually newer version of java
```bash
sudo apg-get install openjdk-7-jdk
```
and select java7 as default java runtim
```bash
sudo update-alternatives --config java
```
I'll fix it asap.

# Analytics vagrant bootstrap
Install Virtualbox, Vagrant (on linux you can use package manager), then clone this repository and run these commands
in clonned repository.

```bash
vagrant up
vagrant provision # when something went wrong during initial bootstrap (net, ...)
```

It takes cca 10 minutes at first start, then you can access vagrant box with `vagrant ssh` command.
Project directories will be shared thru samba on interface with IP 192.168.0.6.66, user is `vagrant` and pasword is `vagrant` as well. 

Analytics backend and frontend has to be started manually for now, you have to do something like:

```bash
vagrant ssh
cd ~/public/analytics-backend
coffee index.coffee
```

and 

```bash
vagrant ssh
cd ~/public/analytics-frontend
grunt
```

If node ends with `EMFILE` error, execute `ulimit -n8192` in shell before running grunt.

Otherwise use your brain, look in `bootstrap.sh`. 

> **BTW** On Mac and Linux you can follow bootstrap.sh to create your local dev environment and don't have to use Vagrant at all.

# Network setup & VPN
- Allow inccoming connections on port 65530 - analytics-backend is broker client!
- Backend uses port 5147 (websocket)
- Hera port 5243
- Frontend 8080(http server) and 35729(live reload)
- All this ports are mapped to your loopback (127.0.0.1)
- Hosted system relies on your VPN connection, so make sure you have proper routes in place (in most cases it should work out of box)

# Windows guide
- Install [Git](http://git-scm.com/downloads) (download windows version)
- At "Adjust your PATH environment" step select "Run Git and included Unix tools from the Windows Command Prompt"
- when installation is finished run (win+r) cmd.exe an type this commands
- `ssh`, `ssh-add`, `bash`
- ...all of them should be present, if not check your %PATH% if it contains `C:\Program Files (x86)\Git\cmd;C:\Program Files (x86)\Git\bin`

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://www.vagrantup.com/downloads.html)
- **reboot Windows**
- ensure your ssh keys are in place (`%HOME%/.ssh/`)
- check if you're in VPN (`ping git.ccl`)
- disable firewalls (see Network setup above or better look at Vagrantfile for list of ports)
- run `cmd.exe`
- `start-ssh-agent`
- check if SSH is working (`ssh git@git.ccl`) it should not ask you for password
- run `vagrant up` in analytics-vagrant directory
- then `vagrant ssh` - you're logged inside the VM