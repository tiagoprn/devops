#!/usr/bin/env bash

DMENU_SCRIPTS_PATH=$HOME/apps/scripts/bin
ROFI_SCRIPTS_PATH=$HOME/apps/scripts/rofi
ROFI_RUN_PREFIX="python3 $ROFI_SCRIPTS_PATH"

# An array of options
declare -A options
options[qutebrowser]="$DMENU_SCRIPTS_PATH/qutebrowser-dmenu-cheatsheet.sh"
options[sxhkd-bspwm]="$DMENU_SCRIPTS_PATH/sxhkd-print-cheatsheet.py | dmenu -fn Monospace:size=12 -c -bw 2 -l 20 -p 'Filter a sxhkd binding:'"
options[tmux]="$DMENU_SCRIPTS_PATH/tmux-dmenu-cheatsheet.sh"
options[vim]="$ROFI_RUN_PREFIX/vim_shortcuts.py -f vim"
options[neovim]="$ROFI_RUN_PREFIX/vim_shortcuts.py -f neovim"
options[ipdb]="$DMENU_SCRIPTS_PATH/ipdb-dmenu-cheatsheet.sh"

# Picking a script
# shellcheck disable=SC2154
while [ -z "$script" ]; do
    script=$(printf '%s\n' "${!options[@]}" | sort | dmenu -fn 'Jetbrains Mono:size=14' -c -bw 2 -l 20 -p 'Choose a cheatsheet to view:') "$@" || exit
    chosen_script="${options["${script}"]}" || exit
done

/bin/bash -c "$chosen_script"
