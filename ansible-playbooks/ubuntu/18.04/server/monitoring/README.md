# Monitoring playbook

This playbook provides a monitoring solution for a ubuntu installation,
providing:

- netdata: collect metrics and provides a dashboard to view them.
- alertmanager: emits alerts when metrics reach a certain threshold.
- prometheus: used as a database (TSDB) to store collected metrics. Also
  provides some basic dashboarding functionality.
- traefik: to expose netdata, alertmanager and prometheus dashboards to the
  outside world through https.

To parametrize alerts to be sent from your SMTP server, you must edit the values
on [the alertmanager role vars](roles/alertmanager/vars/main.yml).

After finishing executing this playbook, you must edit your `/etc/hosts` file
on the machine that is controlling the playbook execution, creating a manual dns
entry pointing to the VM on which the playbook is running. E.g.:
```/etc/hosts
10.160.191.190 www.example.com example.com nginx.example.com traefik.example.com tomcat.example.com mysql.example.com
```

Then the following URLs will be available so you can interact with those services:
- traefik dashboard: https://traefik.example.com
- netdata: http://your-host:19999 (TODO: after finished configuration, change to https://netdata.example.com)
- prometheus: http://your-host:9090/graph (TODO: after finished configuration, change to https://prometheus.example.com)
- alertmanager: http://your-host:9093 (TODO: after finished configuration, change to https://alertmanager.example.com)

Based on [this youtube playlist](https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml).
