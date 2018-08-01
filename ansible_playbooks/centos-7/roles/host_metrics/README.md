## About

This installs collectd (with a plugin to collect information from vmstat),
influxdb to store the metrics and redash to present them beautifully. 

## On collectd

By default collectd does not collect vmstat data. For it to do that, we must
install a python plugin for vmstat from this repository: https://github.com/signalfx/integrations/tree/master/collectd-vmstat

To start the python plugin, if you do not create a SELinux policy to allow it to run you will have many permission errors. 

To create this policy, do the following (as root): 

```
$ systemctl stop collectd
$ audit2allow -a  # This will tell you which permissions are needed by collectd 
$ audit2allow -a -M cgp  # This will create a policy file with the permissions listed above 
$ semodule -i cgp.pp  # This will apply the policy from the file generated 
$ systemctl start collectd
$ systemctl status collectd
```

Repeat the command above until all permissions errors are gone and the service
finally starts (I had to do that many times until it worked).  

### Interesting collectd plugins that can be used to monitor different services: 

- collectd-hugepages
- collectd-mysql
- collectd-nginx
- collectd-postgresql
- collectd-redis
- collectd-rabbitmq
- collectd-virt
- collectd-write_mongodb
- collectd-write_redis

(And remember that you can write your own metrics directly to influxdb, from
python. It should be interesting to monitor uwsgi, and celery workers e.g. ) 

## Notes

- influxdb is installed and then the ansible role connects to it and generates an admin user
  with a random password. The influxdb password is print on screen when running
the role task. To connect to influx using the local client: 

```
influx -username admin -password generated-password-here
``` 

- redash database uri (to connect on influxdb): 

e.g. 

```
influxdb://admin:generated_password@centos7-host-ip:8086/collectd
```

## Redash:

- The Redash container listens on port 443 (https) and redirects trafic from
  http (port 80) to https automatically.

- Admin credentials to redash web ui: 

    url: http://centos7-host-ip e.g. http://10.0.5.100
    email: devops@localhost.localdomain 
    password: admin12345678 (we recommend you change it to a more secure one).

