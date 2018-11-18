#!/bin/bash
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
DOWNLOAD_ROOT=$HOME/tmp

mkdir -p $DOWNLOAD_ROOT

echo "Getting comic URL..."
COMIC=$(wget -qO /dev/stdout http://www.commitstrip.com/?random=1 | grep uploads | grep src | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|].jpg' | uniq)

DOWNLOAD_TO=$DOWNLOAD_ROOT/$TIMESTAMP.jpg

echo "Downloading comic to $DOWNLOAD_TO ..."
curl "$COMIC" -o $DOWNLOAD_TO

echo "Comic saved to $DOWNLOAD_TO ."
