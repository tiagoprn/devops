#!/bin/bash
VERSION=4.0.4
LOG_DIR=/var/log/suricata/
cd /tmp
wget http://downloads.suricata-ids.org/suricata-$VERSION.tar.gz
tar xvzf suricata-$VERSION.tar.gz
cd suricata-$VERSION
./configure --prefix=/usr --sysconfdir=/etc && make && make install-full
groupadd suri
adduser suri -g suri
mkdir -p $LOG_DIR
chown -R suri:suri $LOG_DIR
chown -R suri:suri /etc/suricata

