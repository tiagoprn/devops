#!/usr/bin/env bash

bash ./download_random_commitstrip.sh

COMIC_PATH=$HOME/tmp

PARAM=(--insidecolor=00000000 --ringcolor=0000003e \
    --linecolor=00000000 --keyhlcolor=ffffff80 --ringvercolor=ffffff00 \
    --separatorcolor=22222260 --insidevercolor=ffffff1c \
    --ringwrongcolor=ffffff55 --insidewrongcolor=ffffff1c)

COMIC_PATH=$(find $COMIC_PATH -name *.jpg | sort -r | head -n 1)

i3lock -e -f -n -k --timesize=150 -k "${PARAM[@]}" -i $COMIC_PATH --datestr="%A, %d %b %Y"
