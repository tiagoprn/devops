#!/usr/bin/env bash

bspwm-toggle-visibility.sh flashcard "urxvt --hold -name flashcard --title flashcard -e /bin/bash -c 'fortune -u -e -c /storage/src/fortunes/ | tail +3 | cowsay -b -f dragon -W 80'"
