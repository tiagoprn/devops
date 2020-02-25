#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

STATUS=$(xset -q | grep Caps | sed 's/0[0-2]://g' | sed 's/off/off,/g' | sed 's/on/on,/g' |  sed 's/.$//' | tr -s ' ' | tr '[a-z]' '[A-Z]')
echo -e "$STATUS" | sed 's/,/ | /g' | GREP_COLORS='ms=01;32' grep -E --color 'ON|$'
