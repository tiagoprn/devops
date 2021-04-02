#!/bin/bash

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
	TMUXP_BIN=/usr/local/bin/tmuxp
else
	TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
fi
TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/reminders.yml
