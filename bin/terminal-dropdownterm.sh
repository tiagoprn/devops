#!/bin/bash
DISTRO=$(cat /etc/os-release | grep -e '^ID=' | cut -d = -f 2)

if [[ $DISTRO == "raspbian" ]]; then
  st -n dropdownterm -c Dropdownterm -g 120x45 -e bash -c 'TERM=screen-256color ~/apps/scripts/bin/start_random_tmux_session_name.sh'
else
  alacritty --class dropdownterm --title dropdownterm --hold -e tmux
fi
