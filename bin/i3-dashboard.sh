#!/bin/bash
TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
kitty --name vim --hold bash -c "TERM=screen-256color $TMUXP_BIN load
/storage/src/devops/tmuxp/dashboard.yml"

