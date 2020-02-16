#!/bin/bash

echo 'Running first login script...[WAIT]'

echo 'Configuring locale...[WAIT]'
sudo su -c "cd /etc/default && mv locale locale.ORIG && wget https://raw.githubusercontent.com/tiagoprn/devops/master/raspberry/dockerpi/config/locale "
sudo su -c "cd /etc && mv locale.gen locale.gen.ORIG && wget https://raw.githubusercontent.com/tiagoprn/devops/master/raspberry/dockerpi/config/locale.gen"
sudo su -c "source /etc/default/locale && sudo locale-gen en_US.UTF-8 && sudo update-locale en_US.UTF-8"
sudo su -c "Current locale is: $(echo $LC_ALL)."
echo 'Configuring locale...[DONE]'

# TODO: authorize ssh key for the pi user
# TODO: add ssh key login besides the password login

echo 'Running first login script...[DONE]'
