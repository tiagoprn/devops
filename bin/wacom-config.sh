#!/usr/bin/env bash

set -eou pipefail

# map to monitor
DISPLAY_RESOLUTION=$(xrandr | grep conn | fzf | awk '{print $1}')
echo "Setting wacom output to map output resolution: $DISPLAY_RESOLUTION..."
xsetwacom set "Wacom Intuos S Pen stylus" MapToOutput "$DISPLAY_RESOLUTION"
xsetwacom set "Wacom Intuos S Pen eraser" MapToOutput "$DISPLAY_RESOLUTION"
xsetwacom set "Wacom Intuos S Pen cursor" MapToOutput "$DISPLAY_RESOLUTION"
echo 'DONE.'
