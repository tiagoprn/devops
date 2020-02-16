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

# TODO: authorize ssh key for the pi user
# TODO: add ssh key login besides the password login

touch /run/first_boot_passed

echo 'Running first login script...[DONE]'

