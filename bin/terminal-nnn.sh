#!/bin/bash
DISTRO=$(cat /etc/os-release | grep -e '^ID=' | cut -d = -f 2)

if [[ $DISTRO == "raspbian" ]]; then
  urxvt -name nnn -title nnn --hold -e nnn
else
  alacritty --class nnn --title nnn --hold -e nnn
fi
