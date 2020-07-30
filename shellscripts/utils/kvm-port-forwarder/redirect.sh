#!/bin/bash

# KVM NETWORK TYPE: Nat
# KVM BRIDGE NIC: virbr0
# VM NETWORK: 192.168.122.0/24
# VM IP: 192.168.122.247
# PORT TO FORWARD: 80
# HOST ETHERNET DEVICE: enp7s0

# connections from outside
iptables -I FORWARD -o virbr0 -d  192.168.122.247 -j ACCEPT
iptables -t nat -I PREROUTING -p tcp --dport 80 -j DNAT --to 192.168.122.247:80

# Masquerade local subnet
iptables -I FORWARD -o virbr0 -d  192.168.122.247 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.122.0/24 -j MASQUERADE
iptables -A FORWARD -o virbr0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i virbr0 -o enp7s0 -j ACCEPT
iptables -A FORWARD -i virbr0 -o lo -j ACCEPT
