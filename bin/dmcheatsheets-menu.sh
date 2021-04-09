#!/usr/bin/env bash

DMENU_SCRIPTS_PATH=$HOME/apps/scripts/bin
ROFI_SCRIPTS_PATH=$HOME/apps/scripts/rofi
ROFI_RUN_PREFIX="python3 $ROFI_SCRIPTS_PATH"

# An array of options
declare -A options
options[dwm]="$DMENU_SCRIPTS_PATH/dwm-dmenu-cheatsheet.sh"
options[vim]="$ROFI_RUN_PREFIX/vim_shortcuts.py"

# Picking a script
# shellcheck disable=SC2154
while [ -z "$script" ]; do
    script=$(printf '%s\n' "${!options[@]}" | sort | dmenu -fn Terminus:size=14 -c -bw 2 -l 20 -p 'Choose a cheatsheet to view:') "$@" || exit
    chosen_script="${options["${script}"]}" || exit
done

/bin/bash -c "$chosen_script"
