#!/bin/bash

# Take one argument from the commandline: VM name
if ! [ $# -eq 1 ]; then
    echo "Usage: $0 <vm-name>"
    exit 1
fi

BRIDGE=br1

MAC=$(sudo virsh dumpxml $1 | awk -F\' '/mac address/ {print $2}')
while true
do
	IP=$(sudo grep -B1 $MAC /var/lib/libvirt/dnsmasq/$BRIDGE.status | head \
			-n 1 | awk '{print $2}' | sed -e s/\"//g -e s/,//)
	if [ "$IP" = "" ]
	then
		sleep 1
	else
		break
	fi
done

echo "$(date -R) DONE. SSH to $1 using $IP with  username 'centos'."

