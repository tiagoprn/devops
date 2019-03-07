#!/bin/bash

# Commands inside the EOF definition will run on the remote machine

ssh -i ~/.ssh/key user@mymachine.com <<EOF
    systemctl stop influxdb
    sudo cp -farv /etc/influxdb.conf /etc/influxdb.conf.$(date -u +%Y%m%d.%H%M%S)
    systemctl start influxdb
EOF
