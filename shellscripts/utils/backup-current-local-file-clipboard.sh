#!/usr/bin/env bash

TIMESTAMP=$(date '+%Y%m%d.%H%M%S')

COPY="/tmp/copied.$TIMESTAMP.txt"

cp /tmp/copied.txt $COPY
echo "Backup of '/tmp/copied.txt' is available at '$COPY'."
