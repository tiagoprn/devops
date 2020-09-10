#!/bin/bash
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
DOWNLOAD_ROOT=$HOME/tmp/commitstrip

CURRENT_SCREEN_RESOLUTION=$(xrandr | grep \* | cut -d' ' -f4 -)
echo "resolution=$CURRENT_SCREEN_RESOLUTION"
SCREEN_WIDTH=$(echo $CURRENT_SCREEN_RESOLUTION | cut -d 'x' -f 1)
SCREEN_HEIGHT=$(echo $CURRENT_SCREEN_RESOLUTION | cut -d 'x' -f 2)
echo "width=$SCREEN_WIDTH"
echo "height=$SCREEN_HEIGHT"

mkdir -p $DOWNLOAD_ROOT

notify-send --urgency critical "Getting comic URL..."
COMIC=$(wget -qO /dev/stdout http://www.commitstrip.com/?random=1 | grep uploads | grep src | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|].jpg' | uniq)

echo "COMIC: $COMIC"

FILENAME=$(echo $COMIC | cut -d '/' -f 8)

echo "FILENAME: $FILENAME"

DOWNLOAD_TO=$DOWNLOAD_ROOT/$FILENAME

# exit 1  # TODO: remove  after finishing up

notify-send --urgency critical "Downloading comic to $DOWNLOAD_TO ..."
curl "$COMIC" -o $DOWNLOAD_TO

IMAGE_WIDTH=$(identify -ping -format "%w" $DOWNLOAD_TO)
IMAGE_HEIGHT=$(identify -ping -format "%h" $DOWNLOAD_TO)
echo "$DOWNLOAD_TO width=$IMAGE_WIDTH px, height=$IMAGE_HEIGHT px"

MAXIMUM_HEIGHT=$SCREEN_HEIGHT
X_MAXIMUM_HEIGHT=x$MAXIMUM_HEIGHT

echo "IMAGE_HEIGHT=$IMAGE_HEIGHT"
echo "X_MAXIMUM_HEIGHT=$X_MAXIMUM_HEIGHT"

HEIGHT_SURPASSED=$(python3 -c "print('1' if $IMAGE_HEIGHT > $MAXIMUM_HEIGHT else '0')")

echo "HEIGHT_SURPASSED_MAXIMUM=$HEIGHT_SURPASSED"

if [ $HEIGHT_SURPASSED -eq '1' ]; then
    echo "Resizing $DOWNLOAD_TO to $MAXIMUM_HEIGHT px height..."
    convert -resize $X_MAXIMUM_HEIGHT $DOWNLOAD_TO $DOWNLOAD_TO
fi

notify-send --urgency critical "Comic saved to $DOWNLOAD_TO ."
