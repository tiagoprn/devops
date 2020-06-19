# Monitoring playbook

**IMPORTANT: To parametrize alerts to be sent from your SMTP server, you must edit the values
on [the alertmanager role vars](roles/alertmanager/vars/main.yml) BEFORE
running this playbook.**

This playbook provides a monitoring solution for a ubuntu installation,
providing:

- netdata: collect metrics and provides a dashboard to view them.
- alertmanager: emits alerts when metrics reach a certain threshold.
- prometheus: used as a database (TSDB) to store collected metrics. Also
  provides some basic dashboarding functionality.
- traefik: to expose netdata, alertmanager and prometheus dashboards to the
  outside world through https.


After finishing executing this playbook, you must edit your `/etc/hosts` file
on the machine that is controlling the playbook execution, creating a manual dns
entry pointing to the ip of the VM on which the playbook is running. E.g.:
```/etc/hosts
10.160.191.190 www.example.com example.com traefik.example.com netdata.example.com prometheus.example.com alertmanager.example.com
```

Then the following URLs will be available so you can interact with those services:
- traefik dashboard: https://traefik.example.com
- netdata:  https://netdata.example.com
- prometheus: https://prometheus.example.com
- alertmanager: https://alertmanager.example.com

An http basic authentication is enforced to authenticate on all of the services
available at the URLs above. The playbook generates a user with the same name
of the service and a random password. That password can be retrieved at
`/opt/containers/traefik/[service].passwd`. That in turn is then encrypted into
the htpasswd format, so to provide the authentication securely. The htpasswd
token containing the credential is written to traefik.toml on playbook
execution, and a copy of its' contents can also be found at
`/opt/containers/traefik/[service].htpasswd`.

Based on [this youtube playlist](https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml).
