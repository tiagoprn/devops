#!/bin/bash

set -e

# reference:
# https://eercan.com/post/monitoring-configuration-of-your-linux-devices-machines-using-cockpit/

# apt-get install dirmngr --install-recommends
# apt-key adv --keyserver keyserver.ubuntu.com --recv 7638D0442B90D010 || true
# apt-key adv --keyserver keyserver.ubuntu.com --recv 8B48AD6246925553 || true

# echo 'deb http://deb.debian.org/debian stretch-backports main' > \
#      /etc/apt/sources.list.d/backports.list
apt-get update

apt-get install -y cockpit cockpit-bridge cockpit-dashboard \
    cockpit-doc cockpit-docker cockpit-machines \
    cockpit-networkmanager cockpit-packagekit cockpit-pcp \
    cockpit-storaged cockpit-system cockpit-tests cockpit-ws

echo 'Install finished. Cockpit can be accessed through port :9090.'
