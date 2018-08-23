#!/bin/bash
DESTINATION=$HOME/screenshots
mkdir -p $DESTINATION
notify-send -u critical 'Taking screenshot, select the area with the mouse now...'
scrot -s ~/screenshots/$(date +%Y%m%d.%H%M%S.%N).png -e 'gimp $f'
