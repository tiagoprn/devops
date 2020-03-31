#!/bin/bash

firewall-cmd --permanent --zone=public --add-port=19999/tcp
firewall-cmd --permanent --zone=public --add-port=9090/tcp
firewall-cmd --permanent --zone=public --add-port=9100/tcp
firewall-cmd --permanent --zone=public --add-port=9093/tcp

# ufw allow 19999/tcp

echo "FINISHED!"
