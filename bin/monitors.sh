#!/bin/bash

# Activates the second screen on top of the default (primary) one. 
# If this configuration is not for you, try using arandr do adjust the screen
# and save the configuration. It will be a shellscript on ~/.screenlayout.

hdmi_connected=$(xrandr | grep 'connected' | grep 'HDMI-1'  | awk '{print $2}')

if [ "$hdmi_connected" = "disconnected" ]; then
    echo 'HDMI is disconnected';
    xrandr --output HDMI-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal
else
    echo 'HDMI is connected, it will be positioned top of this screen.';
    xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal
fi
