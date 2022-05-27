#!/bin/bash

# reference: https://github.com/Raymo111/i3lock-color

set -eou pipefail

ROOT_PATH="/opt/i3lock-color"
DOWNLOAD_PATH="$ROOT_PATH/i3lock-color"
CURRENT_USER=$USER

sudo mkdir -p $ROOT_PATH && sudo chown -R "$CURRENT_USER" "$ROOT_PATH"

echo 'Downloading i3lock-color...'
cd $ROOT_PATH && git clone https://github.com/Raymo111/i3lock-color.git

cd $DOWNLOAD_PATH && ./install-i3lock-color.sh

