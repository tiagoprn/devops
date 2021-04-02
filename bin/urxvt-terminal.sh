#!/bin/bash

# notify-send 'Opening bigger urxvt terminal...'
# urxvt -name presentation -cd /storage/docs/notes

WINDOW_NAME=dropdownterm
WIDTH=120
HEIGHT=30

urxvt -name $WINDOW_NAME -title $WINDOW_NAME -geometry ${WIDTH}x${HEIGHT}

