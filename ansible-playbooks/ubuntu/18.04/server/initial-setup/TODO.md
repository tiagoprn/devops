- [ ] See if ssh is protected on the fail2ban task:
  https://www.unixtutorial.org/how-to-use-fail2ban-to-protect-ssh

- [ ] Add a role to configure zram (check also my pocket for more
  configuration):
https://www.techrepublic.com/article/how-to-enable-the-zram-module-for-faster-swapping-on-linux/

- [ ] Configure mitogen to run faster commands on playbooks according to
  (document on tiagopr.nl also):
https://mitogen.readthedocs.io/en/latest/ansible.html

- [ ] Create a role to install and configure s3fs and rclone/nnn (use ansible
        vars: https://gist.github.com/tristanfisher/e5a306144a637dc739e7 )

- [x] Remove tmux from this playbook.

- [x] Remove sysstat (obsolete by the separate host-metrics playbook)

- [x] Remove the collectd firewall rules on `roles/firewalld/tasks/main.yml`
  (they are deprecated by the host_metrics playbook).

