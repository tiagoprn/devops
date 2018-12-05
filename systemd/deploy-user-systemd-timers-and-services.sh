#!/bin/bash

SYSTEMD_HOME=$HOME/.config/systemd
SYSTEMD_USER=$SYSTEMD_HOME/user
SYSTEMD_SCRIPTS=$SYSTEMD_USER/bin

mkdir -p $SYSTEMD_SCRIPTS

cp -farv *.service *.timer $SYSTEMD_USER;

if [ -d "bin" ]
then
    cp bin/* $SYSTEMD_SCRIPTS;
fi

printf '\nHere are the instructions to set the systemd timers and scripts:\n\n'
cat README.md
