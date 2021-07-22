#!/usr/bin/env bash

set -eou pipefail

PACKAGES="ansible cookiecutter ipython s3cmd speedtest-cli tmuxp"
for PACKAGE in $PACKAGES; do
	echo -e "Installing $PACKAGE..."
	pipx install "$PACKAGE" --include-deps
done

