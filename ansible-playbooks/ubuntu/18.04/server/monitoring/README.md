# Monitoring playbook

This playbook provides a monitoring solution for a ubuntu installation,
providing:

- netdata: collect metrics and provides a dashboard to view them.
- alertmanager: emits alerts when metrics reach a certain threshold.
- prometheus: used as a database (TSDB) to store collected metrics. Also
  provides some basic dashboarding functionality.

To parametrize alerts to be sent from your SMTP server, you must edit the values
on [the alertmanager role vars](roles/alertmanager/vars/main.yml).

After finishing executing this playbook, the following URLs will be available
so you can interact with those services:
- netdata: http://your-host:19999
- prometheus: http://your-host:9090/graph
- alertmanager: http://your-host:9093

Based on [this youtube playlist](https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml).
