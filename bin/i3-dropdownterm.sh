#!/bin/bash

#
# Toggle the scratchpad terminal between show and hide.
#
function toggle_terminal {

    if [ "_$(xdotool search --name "dropdownterm" | head -1)"  = "_" ]; then
	echo "Terminal not found, it will be started"
	echo "Renaming window with title dropdownterm so that the class matches the naming"
	lxterminal --title=dropdownterm &
	xprop -name "dropdownterm" -f WM_CLASS 8s -set WM_CLASS "dropdownterm"
    else
	echo "Terminal found, it will not be started again."
	xprop -name "dropdownterm" -f WM_CLASS 8s -set WM_CLASS "dropdownterm"
    fi

}

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
    # TMUXP_BIN=/usr/local/bin/tmuxp
    # urxvt -name vim --hold -e bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/notes.yml";
    # toggle_terminal
    st -f 'Iosevka:size=12:antialias=true:autohint=true' -n dropdownterm -t dropdownterm -c dropdownterm
else
    TMUXP_BIN=$HOME/.pyenv/versions/core-utils/bin/tmuxp
    kitty --name vim --hold bash -c "TERM=screen-256color $TMUXP_BIN load /storage/src/devops/tmuxp/notes.yml";
fi

