#!/usr/bin/env bash

VM_IP=$(sudo virsh net-dhcp-leases vmnet | fzf --prompt 'Choose a running machine to ssh into (user=tds): ' | awk '{print $5}' | cut -d '/' -f 1)
#
# important: include the kvm machine IP on ~/.ssh/config with the IP and user, so that you can refer to it here below by its name
ssh "$VM_IP"
