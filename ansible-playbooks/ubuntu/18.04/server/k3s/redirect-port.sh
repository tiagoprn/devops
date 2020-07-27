#!/bin/bash

# reference:
# <https://stackoverflow.com/questions/47487538/port-forwarding-on-nat-using-kvm-qemu>

VM_SUBNET=192.168.122.0/24
VM_IP=192.168.122.251
VM_PORT=8001
VM_INTERFACE=virbr0
HOST_DESTINATION_PORT=11001

# connections from outside
iptables -t nat -A PREROUTING -p tcp --dport $HOST_DESTINATION_PORT -j DNAT --to $VM_IP:$VM_PORT
# for local connection
iptables -t nat -A OUTPUT -p tcp --dport $HOST_DESTINATION_PORT -j DNAT --to $VM_IP:$VM_PORT

# Masquerade local subnet
iptables -t nat -A POSTROUTING -s $VM_SUBNET -j MASQUERADE
iptables -A FORWARD -o $VM_INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $VM_INTERFACE -o eth0 -j ACCEPT
iptables -A FORWARD -i $VM_INTERFACE -o lo -j ACCEPT
