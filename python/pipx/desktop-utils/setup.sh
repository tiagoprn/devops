#!/usr/bin/env bash

set -eou pipefail

# howdoi <https://github.com/gleitz/howdoi>
# termdown: countdown/stopwatch timer

PACKAGES="pywal telegram-send howdoi termdown"
for PACKAGE in $PACKAGES; do
    echo -e "Installing $PACKAGE..."
    pipx install "$PACKAGE" --include-deps
done
