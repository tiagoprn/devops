#!/bin/bash

st-print-cheatsheet.sh | sed 's/&/&amp;/g' | dmenu -fn Terminus:size=14 -c -bw 2 -l 20 -p 'Filter a st terminal shorcut'
