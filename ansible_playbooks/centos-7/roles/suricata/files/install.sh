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
# Below will run suricata in daemon mode
# LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/suricata -c /etc/suricata/suricata.yaml -i eth0 -l /var/log/suricata –user=suri –group=suri -D
LD_LIBRARY_PATH=/usr/lib suricata -c /etc/suricata/suricata.yaml -i eth0 -l /var/log/suricata --user=suri --group=suri -D

# To check all is working correctly: 
# $ host nsrc.org (that should log an entry on dns.log)
# $ curl -A "BlackSun" www.google.com (that should log an entry on fast.log with "Suspicious User Agent - Network Trojan was detected")

# README: https://suricata-update.readthedocs.io/en/latest/quickstart.html#install-suricata-update

