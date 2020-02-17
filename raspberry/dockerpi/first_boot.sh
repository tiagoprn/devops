#!/bin/bash

echo 'Running first login script...[WAIT]'

if [ -e /run/first_boot_passed ] ; then
    echo 'First boot already passed, nothing to do on first login. [DONE]'
    exit 0;
fi

echo 'Configuring locale...[WAIT]'
sudo su -c "source /etc/default/locale && sudo locale-gen en_US.UTF-8 && sudo update-locale en_US.UTF-8"
sudo su -c "Current locale is: $(echo $LC_ALL)."
echo 'Configuring locale...[DONE]'

echo "Authorize ssh key for the pi user...[WAIT]"
sudo su -c "mkdir -p /home/pi/.ssh"
sudo su -c "chown -R 1000:1000 /home/pi/.ssh"
sudo su -c "chmod 700 /home/pi/.ssh"
sudo su -c "mv /home/pi/authorized_keys /home/pi/.ssh"
sudo su -c "chmod 644 /home/pi/.ssh/authorized_keys"
sudo su -c "chown 1000:1000 /home/pi/.ssh/authorized_keys"
echo "Authorize ssh key for the pi user...[DONE]"

# This is a sinalizer that this script has already run.
# May be used every time I need to check the first boot
# setup process has already finished.
touch /run/first_boot_passed

echo 'Running first login script...[DONE]'

