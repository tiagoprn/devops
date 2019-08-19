#!/usr/bin/env bash

bash /storage/src/devops/bin/download_random_commitstrip.sh;

LOCK_DELAY=2

COMIC_PATH=$HOME/tmp;

PARAM=(--insidecolor=00000000 --ringcolor=0000003e \
    --linecolor=00000000 --keyhlcolor=ffffff80 --ringvercolor=ffffff00 \
    --separatorcolor=22222260 --insidevercolor=ffffff1c \
    --ringwrongcolor=ffffff55 --insidewrongcolor=ffffff1c);

COMIC_PATH=$(find $COMIC_PATH -name '*.jpg' | sort -r | head -n 1);

notify-send --urgency critical "Screen will be locked in $LOCK_DELAY seconds with comic $COMIC_PATH ...";

DATE_HORIZONTAL_POS=1150
DATE_VERTICAL_POS=700
TIME_HORIZONTAL_POS=1000
TIME_VERTICAL_POS=650

sleep $LOCK_DELAY && i3lock -e -f -n -k --datesize=30 --timesize=150 -k "${PARAM[@]}" -i $COMIC_PATH --datestr="%A, %d %b %Y" --datepos="$DATE_HORIZONTAL_POS:$DATE_VERTICAL_POS" --timepos="$TIME_HORIZONTAL_POS:$TIME_VERTICAL_POS";
