#!/bin/bash

set -e

# reference:
# https://eercan.com/post/monitoring-configuration-of-your-linux-devices-machines-using-cockpit/

apt-get install dirmngr --install-recommends
apt-key adv --keyserver keyserver.ubuntu.com --recv 7638D0442B90D010
apt-key adv --keyserver keyserver.ubuntu.com --recv 8B48AD6246925553

echo 'deb http://deb.debian.org/debian stretch-backports main' > \
     /etc/apt/sources.list.d/backports.list
apt-get update
apt-get install cockpit -y

echo 'Install finished. Cockpit can be accessed through port :9090.'
