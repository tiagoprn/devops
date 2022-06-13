#!/bin/bash
CONTENTS=$(cat /storage/src/dwm-flexipatch/config.h | grep 'description: ' | sed 's/{ //g' | sed 's/ }//g'  | sed 's/\/\* description: //g' | sed 's/\*\//=>/g' | sed 's/,//g' | sed 's/\\$//g' | sed 's/\t/ /g' | sed 's/ \+/ /g' | sed 's/MODKEY/SUPER/g' | sed 's/ShiftMask/Shift/g'| sed 's/ControlMask/Ctrl/g' | sed 's/Mod1Mask/Alt/g' | sed 's/|/\+/g' | sed 's/ XK_/\+/g' | sed 's/spawn SHCMD(//g' | sed 's/)$//g' | sed 's/TAGKEYS(//g' | sed 's/STACKKEYS(//g' | sort)

# sleep 3 && alacritty --title dropdownterm -e /bin/bash -c "echo '$CONTENTS' | peco" --hold &
urxvt --hold --title dropdownterm -e /bin/bash -c "echo '$CONTENTS' | peco"
