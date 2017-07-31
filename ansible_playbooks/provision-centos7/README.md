## Provision a CentOS 7 server

This playbook can provision a freshly installed CentOS 7 server with the following: 

* EPEL repository 
* syslog-ng repository, version 3.10, and its corresponding binaries
* auditd with custom configuration rules 
* Development Tools (git, svn, kernel headers, etc...) 
* Miscelaneous utilities (`sysstat` between them, with is useful to collect server metrics and persist a daily consolidated report of it on the syslog-ng log path)
* sysctl configuration, with focus on hardening the server 
* docker-ce repository, which provides the most recent docker
* portainer, a docker container which provides a Web UI to managing docker containers, locally or remotely
* docker-compose (installed through the system python pip) 
* fail2ban, for added security 
* a `dev` user account, so the server can be accessed by the ansible host without using root or username/passwords
* `tmux` and a custom configuration based on my dot files, for the user `dev`.
* `bashrc` and `vimrc` based on my dot files, for the user `dev`. 
* `ntp`, configured for Brazil time
