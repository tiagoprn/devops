#!/bin/bash

firewall-cmd --permanent --zone=public --add-port=19999/tcp
# ufw allow 19999/tcp

echo "FINISHED!"
