# Below will run suricata in daemon mode

```
LD_LIBRARY_PATH=/usr/lib suricata -c /etc/suricata/suricata.yaml -i eth0 -l /var/log/suricata --user=suri --group=suri -D
```

# To check all is working correctly: 

```
$ host nsrc.org  # (that should log an entry on dns.log)
$ curl -A "BlackSun" www.google.com  # (that should log an entry on fast.log with "Suspicious User Agent - Network Trojan was detected")
```

