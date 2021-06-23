#!/bin/bash
DISTRO=$(cat /etc/os-release | grep -e '^ID=' | cut -d = -f 2)

if [[ $DISTRO == "raspbian" ]]; then
  nohup st -n dropdownterm -c Dropdownterm -g 120x45 -e bash -c 'TERM=screen-256color ~/apps/scripts/bin/start_random_tmux_session_name.sh'
else
  TMUXP="$HOME/.pyenv/versions/core-utils/bin/tmuxp"

  if [ -z "$TMUXP" ]; then
    TMUXP='tmuxp'

    if [ -z "$TMUXP" ]; then
      echo missing tmuxp, please install to proceed.
      exit 1
    fi

  fi

  alacritty --class dropdownterm --title dropdownterm -e bash -c "$TMUXP load /storage/src/devops/tmuxp/notes-and-reminders.yml" --hold
fi
