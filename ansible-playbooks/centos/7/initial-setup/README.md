# CentOS 7 provisioning playbook 

This is a modular ansible playbook, which can be used to setup a new CentOS 7 server instance. 

This setup does its best to provide security (although I'm by no means an expert on it I tried my best through researching), logs and metrics monitoring. The following is provided: 

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
- host_metrics: collectd to store metrics, influxdb to persist them and redash with visualizations configured to see them on beautiful dashboards. :) 
- dotfiles: my dot files to vim, bash, git, etc...
- configures tmux and vim according to my dotfiles
- services: starts all daemons from the playbook 
- cleanup: do some final cleaning up (remove yum cache, etc...)


## Important: 

- Specially due to the fact that this scripts installs a local
postgres database for redash, it it recommended that it runs on machines/VMs with
2GB+ of RAM for it to finish successfully. I had errors running it on a 1GB RAM
VM with exit code 137 on the setup_redash_container task, probably due to that
fact.

- To make some benchmarks after the playbook finishes, you can use two tools
  that are installed: 

    - stress-ng 
    - ioping

On my [personal blog](https://tiagopr.nl), you can find instructions on how to
use both of them.

- The roles `host_metrics` and `suricata` have their own README files on their folders with addicional instructions. 

- You can find the auto-generated password to the influxdb admin user at `/root/influxdb.admin.passwd`, and the portainer admin password at `/opt/containers/portainer/admin.passwd`. Both are also print when the playbook runs. 

- All content related to the containers (especially the docker-compose files) is located at `/opt/containers`. 

- The self-signed TLS certificates to access Portainer and Redash are at `/certificates`. 

- To access the redash web UI to see the system metrics: 

    URL: https://your-centos-host-ip-or-name
    email: devops@localhost.localdomain
    password: admin12345678 (change it as soon as possible) 

- To access the portainer Web UI to manage containers: 

    URL: https://your-centos-host-ip-or-name:9000
    user: admin 
    password: (enter the one generated at `/opt/containers/portainer/admin.passwd`)


## References: 
- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment
- https://github.com/stefangweichinger/ansible-rclone/blob/master/vars/Ubuntu.yml (used as the base for the rclone role).

