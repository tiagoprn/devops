# Ubuntu 18.04 provisioning playbook

This is a modular ansible playbook, which can be used to setup a new Ubuntu 18.04 instance.

This setup does its best to provide security (although I'm by no means an expert on it I tried my best through researching). The following is provided:

- Development tools (compilers, git, python pip and other dependencies to build packages)
- suricata: an IDS, useful to report suspicious activity on the machine related to malware and other security threats (the idea is to scan against the most updated possible list of threats).
- sysctl configuration for tuning kernel parameters
- fail2ban: scans log files and ban IPs that show malicious activity
- auth: create a sudo user with access to the docker daemon and also sets the ssh keys for it.
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

- *suricata* is cpu-bound. Testing it locally on a VM created with multipass on
  Ubuntu 18.04 with 1 CPU and 1 GB of RAM, it consistently raised the CPU to
100% each and every 5 seconds. So the advice it to disable that service when
you are restricted to just one CPU.

## References:
- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment

