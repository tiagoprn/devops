#!/usr/bin/env bash

TIMESTAMP=$(date '+%Y%m%d.%H%M%S')

COPY="/tmp/clipboard/copied.$TIMESTAMP.txt"

cp /tmp/clipboard/copied.txt $COPY
echo "Backup of '/tmp/clipboard/copied.txt' is available at '$COPY'."
