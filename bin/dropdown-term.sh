#!/bin/bash

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
    urxvt -name dropdownterm --hold -e bash -c "TERM=screen-256color /bin/bash";
else
    kitty --name dropdownterm --hold bash -c "TERM=screen-256color /bin/bash";
fi

