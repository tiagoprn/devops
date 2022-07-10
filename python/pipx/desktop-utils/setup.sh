#!/usr/bin/env bash

set -eou pipefail

# crazydiskmark:  to bookmark disks - equivalent to CrystalDiskMark on windows - needs python 3.8
# howdoi <https://github.com/gleitz/howdoi>
# termdown: countdown/stopwatch timer

PACKAGES="pywal telegram-send crazydiskmark howdoi termdown"
for PACKAGE in $PACKAGES; do
    echo -e "Installing $PACKAGE..."
    pipx install "$PACKAGE" --include-deps
done
