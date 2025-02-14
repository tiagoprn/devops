#!/usr/bin/env bash
# In the example above, the interface is `vnet2` and the ip is `192.168.122.116`.

VM_IP=$(ip -o -4 addr show dev $(ip -o link show | awk '/enp/{print $2}' | sed 's/://') | awk '{print $4}' | cut -d/ -f1)

sudo iptables -t nat -A PREROUTING -p tcp --dport 3306 -j DNAT --to-destination $VM_IP:3306
sudo iptables -t nat -A POSTROUTING -p tcp -d $VM_IP --dport 3306 -j MASQUERADE

sudo iptables -t nat -A PREROUTING -p tcp --dport 4200 -j DNAT --to-destination $VM_IP:4200
sudo iptables -t nat -A POSTROUTING -p tcp -d $VM_IP --dport 4200 -j MASQUERADE

echo 'Listing rules on port to make sure it worked:'

/storage/src/devops/shellscripts/kvm/guests/ubuntu-2204/list-iptables-custom-ports.sh 3306
/storage/src/devops/shellscripts/kvm/guests/ubuntu-2204/list-iptables-custom-ports.sh 4200
