#!/bin/bash

# reference: https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/#easily-order-windows

# In short, this script takes a process name (which is a class name or instance name, obtainable by xprop) and searches for it. Then, it applies a rule based on its status.

window_id=${1}
command=${2}

echo "window_id: ${window_id}"
echo "command: ${command}"

# Get id of process by class name and then fallback to instance name
id=$(wmctrl -l | grep $window_id | awk '{print $1}')

echo "Looking for window $id ..."

if [ -z "${id}" ]; then
    ${command} && sleep 0.2
    new_id=$(wmctrl -l | grep $window_id | awk '{print $1}')
    bspc node "$new_id" --focus -t floating
    echo "Window $new_id focused."
else
    echo "Window $id toggled visibility."
    bspc node "$id" --flag hidden --to-monitor focused --focus -t floating
fi

