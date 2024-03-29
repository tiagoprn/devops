# Monitoring playbook

**IMPORTANT: To parametrize alerts to be sent from your SMTP server, you must copy alertmanager's sample role vars file `roles/alertmanager/vars/main.yml.sample` to `roles/alertmanager/vars/main.yml` BEFORE running this playbook.**

This playbook provides a monitoring solution for a ubuntu host, providing:

- **netdata:** native install - collect metrics and provides a dashboard to view them.
- **alertmanager:** native install - emits alerts when metrics reach a certain threshold.
- **prometheus:** native install - used as a database (TSDB) to store collected metrics. Also provides some basic dashboarding functionality.
- **traefik (1.x):** container install - to expose netdata, alertmanager and prometheus dashboards to the outside world through http basic authentication (using bcrypt) through https.

After finishing executing this playbook, you must edit your `/etc/hosts` file on the machine that is controlling the playbook execution, creating a manual dns entry pointing to the ip of the VM on which the playbook is running. E.g.:
```/etc/hosts
10.160.191.190 www.example.com example.com traefik.example.com netdata.example.com prometheus.example.com alertmanager.example.com
```

Then the following URLs will be available so you can interact with those services:
- traefik dashboard: https://traefik.example.com
- netdata:  https://netdata.example.com
- prometheus: https://prometheus.example.com
- alertmanager: https://alertmanager.example.com

An http basic authentication is enforced to authenticate on all of the services available at the URLs above. The playbook generates a user with the same name of the service and a random password. That password can be retrieved at `/opt/containers/traefik/[service].passwd`. That in turn is then encrypted into the htpasswd format, so to provide the authentication securely. The htpasswd token containing the credential is written to traefik.toml on playbook execution, and a copy of its' contents can also be found at `/opt/containers/traefik/[service].htpasswd`.

Based on [this youtube playlist](https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml).

This playbook can also be used as a base for a custom solution where you need to deploy your custom services/apps to a server, since you can take advantage from traefik as a reverse proxy to your custom services/apps. But you will have to figure out on yourself how to do it. If you want to use kubernetes, use the [k3s playbook](https://github.com/tiagoprn/devops/tree/master/ansible-playbooks/ubuntu/18.04/server/k3s) instead.

