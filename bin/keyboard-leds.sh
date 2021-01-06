#!/bin/bash

STATUS=$(xset -q | grep Caps | sed 's/0[0-2]://g' | sed 's/off/off,/g' | sed 's/on/on,/g' |  sed 's/.$//' | tr -s ' ' | tr '[a-z]' '[A-Z]' | sed 's/,/ | /g' | sed 's/LOCK//g' | sed 's/ ://g' | sed 's/  / /g')

if [[ "$STATUS" == *"ON"* ]]; then
    COLOR='#00FF00';
else
    COLOR='#FFFFFF';
fi

# To change color of the text on the block, the output must have three lines and the third one must
# be a hexadecimal color.
echo -e "$STATUS";
