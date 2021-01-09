#!/bin/bash

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
	TMUXP_BIN=/usr/local/bin/tmuxp
	urxvt -hold -title personalcalendar  -e bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/calendar.yml";
else
	TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
	kitty --name personal-calendar --hold bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/calendar.yml"
fi
