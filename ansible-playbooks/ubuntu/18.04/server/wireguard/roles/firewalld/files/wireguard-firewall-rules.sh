#!/bin/bash

firewall-cmd --permanent --zone=public --add-port=51820/udp

# ufw allow 51820/udp

echo "FINISHED!"
