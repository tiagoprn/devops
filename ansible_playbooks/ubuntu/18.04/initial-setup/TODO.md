- [ ] role start_container: debug inside the lxd container why the influxdb collectd database is not being created.
    - [ ] Copy the orifinal influxdb.conf file before overwriting with my own
    - [ ] on influxdb, manually create the collectd database on the host_metrics role (since systemctl status influxdb
      seems to be getting data from vmstat_collectd.py according to the logs shown there)
    - [ ] check firewalld if it has collectd port 8086 open, or if it needs other ports like 8096
- [ ] configure mitogen to run faster commands on playbooks according to (document on tiagopr.nl also): https://mitogen.readthedocs.io/en/latest/ansible.html
- [ ] Create a role to install and configure s3fs and borgbackup (from environment variables).
- [ ] On each role, add a README.md briefly explaining what it does.

