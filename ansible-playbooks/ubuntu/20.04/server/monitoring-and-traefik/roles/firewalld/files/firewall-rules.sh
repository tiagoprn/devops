#!/bin/bash

# Adding an internal zone to the firewall, mapped to localhost and docker interfaces
firewall-cmd --permanent --zone=internal --add-interface=lo --add-interface=docker0

# Ports allowed internally (localhost and docker)
## node_exporter:
firewall-cmd --permanent --zone=internal --add-port=9100/tcp
## netdata:
firewall-cmd --permanent --zone=internal --add-port=19999/tcp
## prometheus:
firewall-cmd --permanent --zone=internal --add-port=9090/tcp
## alertmanager:
firewall-cmd --permanent --zone=internal --add-port=9093/tcp

# Ports allowed on LAN/WAN
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
