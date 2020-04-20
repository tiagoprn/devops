#!/bin/bash

# Adding an internal zone to the firewall, mapped to localhost interface
firewall-cmd --permanent --zone=internal --add-interface=lo


# Ports only allowed on localhost
## node_exporter:
firewall-cmd --permanent --zone=internal --add-port=9100/tcp
## netdata:
firewall-cmd --permanent --zone=internal --add-port=19999/tcp
## prometheus:
firewall-cmd --permanent --zone=internal --add-port=9090/tcp
## alertmanager:
firewall-cmd --permanent --zone=internal --add-port=9093/tcp


# Ports available on LAN/WAN
## netdata:
# firewall-cmd --permanent --zone=public --add-port=19999/tcp
## prometheus:
# firewall-cmd --permanent --zone=public --add-port=9090/tcp
## alertmanager:
# firewall-cmd --permanent --zone=public --add-port=9093/tcp
## traefik dashboard:
firewall-cmd --permanent --zone=public --add-port=8080/tcp

# Example to set ubuntu's ufw:
# ufw allow 19999/tcp

echo "FINISHED!"
