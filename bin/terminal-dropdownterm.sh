#!/bin/bash
DISTRO=$(cat /etc/os-release | grep -e '^ID=' | cut -d = -f 2)

if [[ $DISTRO == "raspbian" ]]; then
  st -n dropdownterm -c Dropdownterm -g 120x45
else
  alacritty --class dropdownterm --title dropdownterm --hold -e tmux
fi
