#!/bin/bash

echo 'Running first login script...[WAIT]'

echo 'Configuring locale...[WAIT]'
sudo bash -c "cd /etc/default && mv locale locale.ORIG && wget https://raw.githubusercontent.com/tiagoprn/devops/master/raspberry/dockerpi/config/locale "
sudo bash -c "cd /etc && mv locale.gen locale.gen.ORIG && wget https://raw.githubusercontent.com/tiagoprn/devops/master/raspberry/dockerpi/config/locale.gen"
sudo bash -c "source /etc/default/locale && sudo locale-gen en_US.UTF-8 && sudo update-locale en_US.UTF-8"
echo 'Configuring locale...[DONE]'

# TODO: authorize ssh key for the pi user
# TODO: add ssh key login besides the password login

echo 'Running first login script...[DONE]'
