#!/bin/bash

SYSTEMD_HOME=$HOME/.config/systemd
SYSTEMD_USER=$SYSTEMD_HOME/user

mkdir -p $SYSTEMD_HOME 

if [ ! -d "${SYSTEMD_USER}" ]
then
    ln -s /storage/src/devops/systemd $SYSTEMD_USER;
else
    printf '\nSystemD user directory already exists, nothing to be done here.\n'    
fi

printf '\nHere are the instructions to set the systemd timers:\n\n'
cat README.md
