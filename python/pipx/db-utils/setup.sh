#!/usr/bin/env bash

set -eou pipefail

PACKAGES="pgcli mycli litecli visidata csvkit"
for PACKAGE in $PACKAGES; do
    echo -e "Installing $PACKAGE..."
    pipx install "$PACKAGE" --include-deps
done
