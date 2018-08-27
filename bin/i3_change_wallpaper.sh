#!/bin/bash

# If there is not an image fallback.png on ~/Wallpapers, set the wallpaper 
# to the most recent file at ~/Wallpapers (based on the file timestamp)

WALLPAPERS_PATH=$HOME/Wallpapers
FALLBACK_IMAGE=$WALLPAPERS_PATH/fallback.png

if [ ! -f $FALLBACK_IMAGE ]; then
    echo "Setting the wallpaper to the most recent one at $WALLPAPERS_PATH..."
    feh --bg-scale $(find ~/Wallpapers -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1)
else
    echo "Since the fallback image is at $FALLBACK_IMAGE , setting it as the wallpaper."
    feh --bg-scale $HOME/Wallpapers/fallback.png        
fi

