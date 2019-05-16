#!/bin/bash
PERCENTAGE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i 'percentage'| cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//' )
STATE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i 'state'| cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//' )
REMAINING=''
if [ "$STATE" = "discharging" ]; then
    REMAINING="(0% in $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i 'time to empty'| cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//'))"
fi
echo "$PERCENTAGE, $STATE $REMAINING"
