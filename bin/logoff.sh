#!/bin/bash

OS_NAME=$(cat /etc/os-release  | grep '^ID=' | cut -d '=' -f 2)
if [ "$OS_NAME" == "raspbian" ]; then
	fusermount  -u /storage || (notify-send -t 5000 -u critical "Finish all processes open on '/storage' and try again." && exit 1)
	loginctl terminate-user pi
else
	i3-msg exit
fi

