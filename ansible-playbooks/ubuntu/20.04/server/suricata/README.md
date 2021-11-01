# Suricata provisioning playbook

**You must copy suricata's sample role vars file `roles/suricata/vars/main.yml.sample` to `roles/suricata/vars/main.yml` BEFORE running this playbook.**

This setup does provisions [suricata](https://suricata.io/) setup as a tool to enhance the security of an environment.

The following roles are provided:

- suricata: an IDS, useful to report suspicious activity on the machine related to malware and other security threats (the idea is to scan against the most updated possible list of threats).

- services: starts all daemons from the playbook

- cleanup: do some final cleaning up (remove caches, etc...)


## Important:

- This playbook was created when suricata was removed from my other `initial-setup` playbook on 2021-10-19.

- This playbook uses the ansible facts pattern to detect if it should or not run a role each time. Facts are a nice way to run rules in an idempotent way.

- *suricata* is cpu-bound. Testing it locally on a VM created with multipass on Ubuntu 18.04 with 1 CPU and 1 GB of RAM, it consistently raised the CPU to 100% each and every 5 seconds. So the advice it to disable that service when you are restricted to just one CPU.


## References:

- https://www.digitalocean.com/community/tutorials/how-to-use-ansible-roles-to-abstract-your-infrastructure-environment

