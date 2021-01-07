#!/bin/bash

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
	TMUXP_BIN=/usr/local/bin/tmuxp
	bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/notes.yml";
else
	TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
	kitty --name vim --hold bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/notes.yml"
fi
