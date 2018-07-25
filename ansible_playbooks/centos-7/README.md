# CentOS 7 provisioning playbook 

Important: given specially due to the fact that this scripts installs a local
postgres database for redash, it it recommended that it runs on machines/VMs with
2GB+ of RAM for it to finish successfully. I had errors running it on a 1GB RAM
VM with exit code 137 on the setup_redash_container task, probably due to that
fact.

This is a modular ansible playbook, which can be used to setup a new CentOS 7 server instance. 

This setup does its best to provide security, logs and metrics monitoring. The following is provided: 

- Development tools (compilers, git, python pip and other dependencies to build packages)
- auditd rules: auditd is useful to monitor pretty much anything that happens on the linux kernel, prividing logs and watchs for interesting system calls (providing a hook into any system operation we could possibly want). It is also used as the logger for SELinux.
- rclone: to backup data from/into S3-compatible storages.
- suricata: an IDS, useful to report suspicious activity on the machine related to malware and other security threats (the idea is to scan against the most updated possible list of threats). 
- sysstat: to get performance metrics on a linux system
- sysctl configuration for tuning kernel parameters 
- docker/portainer: docker daemon and a web UI to interact with it. 
- fail2ban: scans log files and ban IPs that show malicious activity
- auth: create a sudo user with access to the docker daemon and also sets the ssh keys for it. 
- tmux: the tmux multiplexer, with my custom configuration for it 
- timezone/ntp configured for America/Sao_Paulo.
- host_metrics: collectd to store metrics, influxdb to persist them and grafana to see them on beautiful dashboards. :) 
- dotfiles: my dot files to vim, bash, git, etc...
- configures tmux and vim according to my dotfiles
- services: starts all daemons from the playbook 
- cleanup: do some final cleaning up (remove yum cache, etc...)

References: 
- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment
- https://github.com/stefangweichinger/ansible-rclone/blob/master/vars/Ubuntu.yml (used as the base for the rclone role).

