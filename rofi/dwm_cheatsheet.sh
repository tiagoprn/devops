#!/bin/bash
dwm-print-cheatsheet.sh | sed 's/&/&amp;/g' |  rofi -dmenu -markup -markup-rows -fullscreen --no-case-sensitive -p "Filter a dwm shorcut"
