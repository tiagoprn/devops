#!/bin/bash

# TODO: migrate to a python script and implement the notifications.

DIR=$(pwd)

BAT="$(ls /sys/class/power_supply/ | grep -i BAT | head -n 1)"; BATTERY="$(cat /sys/class/power_supply/$BAT/capacity)"
echo "BAT=$BAT, BATTERY=$BATTERY"

AC="$(ls /sys/class/power_supply/ | grep -i AC | head -n 1)"; CHARGE=$(cat /sys/class/power_supply/$AC/online)
echo "AC=$AC, CHARGE=$CHARGE"

SETTER="feh --bg-scale"

function set_wallpaper_charge {
    $SETTER $DIR/images/charge_$1.png
}

function set_wallpaper_bat {
    $SETTER $DIR/images/battery_$1.png
}

function animate_wallpaper {
    for i in {1..5}; do
        # cycle through charging images
        set_wallpaper_charge $i; sleep 0.8
    done
}

function main {
    ORIGINAL_WALLPAPER=$HOME/.fehbg
    cp -farv $ORIGINAL_WALLPAPER $ORIGINAL_WALLPAPER.bkp
	## Charging Animation
    if [[ $CHARGE -eq "1" ]] && [[ $BATTERY -lt "100" ]]; then
        animate_wallpaper
    ## Stop Animation When Fully Charged
    elif [[ $CHARGE -eq "1" ]] && [[ $BATTERY -eq "100" ]]; then
        notify-send "Battery fully charged, returning to the original wallpaper now."
        cp -farv $ORIGINAL_WALLPAPER.bkp $ORIGINAL_WALLPAPER
        /bin/bash $ORIGINAL_WALLPAPER
        exit 0
    ## Change According To Battery Percentage
    else
        num=$(($BATTERY/20+"1"))
        set_wallpaper_bat $num; sleep 5
    fi
}

while true; do
	main && exec $DIR/battery_wall.sh
done
