#!/usr/bin/env bash

set -eou pipefail

INSTALL_PATH=$HOME/src/hugo

mkdir -p "$INSTALL_PATH"
git clone https://github.com/gohugoio/hugo.git "$INSTALL_PATH"

echo 'Compiling and installing hugo extended...'
cd "$INSTALL_PATH" && CGO_ENABLED=1 go install --tags --extended && sudo cp

sudo cp -farv "$HOME/go/bin/hugo" /usr/bin/

echo 'FINISHED. Hugo was successfully compiled and copied to "/usr/bin/hugo".'
