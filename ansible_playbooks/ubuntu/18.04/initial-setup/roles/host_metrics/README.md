## About

This installs collectd (with a plugin to collect information from vmstat) and
influxdb to store the metrics.

## On collectd

By default collectd does not collect vmstat data. For it to do that, we must
install a python plugin for vmstat from this repository: https://github.com/signalfx/integrations/tree/master/collectd-vmstat

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

e.g.

influx -username admin -password $(cat /root/influxdb.admin.passwd)
```

