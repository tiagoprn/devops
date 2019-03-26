#!/bin/bash
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
DOWNLOAD_ROOT=$HOME/tmp

mkdir -p $DOWNLOAD_ROOT

notify-send --urgency critical "Getting comic URL..."
COMIC=$(wget -qO /dev/stdout http://www.commitstrip.com/?random=1 | grep uploads | grep src | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|].jpg' | uniq)

DOWNLOAD_TO=$DOWNLOAD_ROOT/$TIMESTAMP.jpg

notify-send --urgency critical "Downloading comic to $DOWNLOAD_TO ..."
curl "$COMIC" -o $DOWNLOAD_TO

IMAGE_WIDTH=$(identify -ping -format "%w" $DOWNLOAD_TO)
IMAGE_HEIGHT=$(identify -ping -format "%h" $DOWNLOAD_TO)
notify-send --urgency critical "$DOWNLOAD_TO width=$IMAGE_WIDTH px, height=$IMAGE_HEIGHT px"

HEIGHT_SURPASSED=$(python -c "print('1' if $IMAGE_HEIGHT > 1080 else '0')")
notify-send --urgency critical "HEIGHT_SURPASSED_1080px=$HEIGHT_SURPASSED"

if [ $HEIGHT_SURPASSED -eq '1' ]; then
    notify-send --urgency critical "Resizing $DOWNLOAD_TO to 1080px height..."
    convert -resize x1080 $DOWNLOAD_TO $DOWNLOAD_TO
fi

notify-send --urgency critical "Comic saved to $DOWNLOAD_TO ."
