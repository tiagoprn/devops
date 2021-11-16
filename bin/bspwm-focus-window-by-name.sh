#!/usr/bin/env bash

WINDOW_NAME=$(wmctrl -l | fzf | awk '{print $NF}')

bspc node  -f xdotool search --name "$WINDOW_NAME"
