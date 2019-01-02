# Available playbooks:

- initial-setup: a playbook to setup a server with security, docker and monitoring in mind.

# Python interpreter for Ubuntu 18.04+

Since from that version up Ubuntu only supports python 3, we must edit our
ansible hosts file according to that. E.g.:

```
[lxd-ubuntu]
10.0.10.11 ansible_become=true ansible_user=ubuntu ansible_become_method=sudo

[lxd-ubuntu:vars]
ansible_python_interpreter=/usr/bin/python3
```

