# Ubuntu 18.04 provisioning playbook

This is a modular ansible playbook, which can be used to setup a new Ubuntu 18.04 instance.

This setup does its best to provide security (although I'm by no means an expert on it I tried my best through researching). The following is provided:

- build tools (compilers, git, etc...), python pip, curl, wget, mosh, tmux etc
- utilities (rsync, htop, unzip, vim, etc...)
- sysctl configuration for tuning kernel parameters
- fail2ban: scans log files and ban IPs that show malicious activity (configured for ssh)
- auth: create a sudo user with access to the docker daemon and also sets the ssh keys for it.
- timezone/ntp configured for America/Sao_Paulo.
- firewalld configuration
- services: starts all daemons from the playbook
- cleanup: do some final cleaning up (remove caches, etc...)


## Important:

- To make some benchmarks after the playbook finishes, you can use two tools:

    - stress-ng
    - ioping

On my [personal blog](https://tiagopr.nl), you can find instructions on how to use both of them.

- This playbook uses the ansible facts pattern to detect if it should or not run a role each time. Facts are a nice way to run rules in an idempotent way.


## References:
- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment

