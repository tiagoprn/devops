#!/bin/bash

if [ -x "$(command -v wal)" ]; then
    wal -R
else
    echo 'wal command is not installed. Nothing to do.'
fi

exit 0
