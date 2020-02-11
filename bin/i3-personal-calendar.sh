#!/bin/bash
TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
kitty --name personal-calendar --hold bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/calendar.yml"

