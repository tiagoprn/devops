#!/bin/bash

# Shows if dunst notifications are paused.

IS_PAUSED=$(dunstctl is-paused)

if [ "$IS_PAUSED" == 'true' ]; then
    # echo 'IS TRUE \o/'
    STATUS=" "
else
    # echo 'IS FALSE :('
    STATUS=" "
fi

echo -e " = $STATUS"
