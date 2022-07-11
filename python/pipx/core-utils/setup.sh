#!/usr/bin/env bash

set -eou pipefail

# jetty: alternative to jq

PACKAGES="pre-commit ansible cookiecutter ipython s3cmd speedtest-cli tmuxp jetty"
for PACKAGE in $PACKAGES; do
    echo -e "Installing $PACKAGE..."
    pipx install "$PACKAGE" --include-deps
done
