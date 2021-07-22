#!/usr/bin/env bash

set -eou pipefail

PACKAGES="vdirsyncer khal"
for PACKAGE in $PACKAGES; do
	echo -e "Installing $PACKAGE..."
	pipx install "$PACKAGE" --include-deps
done

