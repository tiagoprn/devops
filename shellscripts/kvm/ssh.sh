#!/usr/bin/env bash

VM_IP=$(sudo virsh net-dhcp-leases vmnet | fzf --prompt 'Choose a running machine to ssh into (user=tds): ' | awk '{print $5}' | cut -d '/' -f 1)
ssh tds@"$VM_IP"
