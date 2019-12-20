#!/bin/bash
DESTINATION=~/bin/kitty-installer
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=$DESTINATION
ln -s ~/bin/kitty-installer/kitty.app/bin/kitty ~/bin/kitty
