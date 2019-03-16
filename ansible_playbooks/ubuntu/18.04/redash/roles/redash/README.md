- redash database uri (to connect on influxdb):

e.g.

```
influxdb://admin:generated_password@host-ip:8086/collectd
```

- The Redash container listens on port 443 (https) and redirects trafic from
  http (port 80) to https automatically.

- Admin credentials to redash web ui:

    url: http://centos7-host-ip e.g. http://10.0.5.100
    email: devops@localhost.localdomain
    password: admin12345678 (we recommend you change it to a more secure one).

