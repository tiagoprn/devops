# Ubuntu 18.04 provisioning playbook

This is a modular ansible playbook, which can be used to setup a new Ubuntu 18.04 server instance.

This setup does its best to provide security (although I'm by no means an expert on it I tried my best through researching). The following is provided:

- Development tools (compilers, git, python pip and other dependencies to build packages)
- suricata: an IDS, useful to report suspicious activity on the machine related to malware and other security threats (the idea is to scan against the most updated possible list of threats).
- sysstat: to get performance metrics on a linux system
- sysctl configuration for tuning kernel parameters
- docker/portainer: docker daemon and a web UI to interact with it.
- fail2ban: scans log files and ban IPs that show malicious activity
- auth: create a sudo user with access to the docker daemon and also sets the ssh keys for it.
- tmux: the tmux multiplexer
- timezone/ntp configured for America/Sao_Paulo.
- services: starts all daemons from the playbook
- cleanup: do some final cleaning up (remove caches, etc...)


## Important:

- To make some benchmarks after the playbook finishes, you can use two tools
  that are installed:

    - stress-ng
    - ioping

On my [personal blog](https://tiagopr.nl), you can find instructions on how to
use both of them.

- This playbook uses the ansible facts pattern to detect if it should or not run a role each time.
  Facts are a nice way to run rules in an idempotent way.

## References:
- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment

