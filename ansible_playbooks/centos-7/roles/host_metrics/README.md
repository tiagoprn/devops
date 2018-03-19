## About

This installs collectd (with a plugin to collect information from vmstat),
influxdb to store the metrics and grafana to present them beautifully. 

## Notes

- grafana.ini is generated from a jinja2 template, since the password will be
randomically generated. 

- To login on grafana, you must use the following credentials: 

```
URL: [vm_host]:3000
USER: admin
PASSWORD: [check grafana.ini: $ sudo cat /etc/grafana/grafana.ini | grep admin_password) 
```

## Interesting collectd plugins that can be used to monitor different services: 

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

## And here are some queries you can try on your grafana server related to
`vmstat`: 

SELECT mean("value") AS cs FROM "vmstat_value" WHERE $timeFilter AND type_instance='cs' GROUP BY time($__interval) fill(null)
SELECT mean("value") AS wa FROM "vmstat_value" WHERE $timeFilter AND type_instance='wa' GROUP BY time($__interval) fill(null)
SELECT mean("value") AS in_m FROM "vmstat_value" WHERE $timeFilter AND type_instance='in' GROUP BY time($__interval) fill(null) 

