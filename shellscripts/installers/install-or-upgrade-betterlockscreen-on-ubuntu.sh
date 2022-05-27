#!/bin/bash

set -eou pipefail

echo 'You must have i3lock-color installed for this to work...' && sleep 5

ROOT_PATH="/opt/betterlockscreen"
DOWNLOAD_PATH="$ROOT_PATH/betterlockscreen-main"
BIN_PATH=/usr/local/bin/
CURRENT_USER=$USER

sudo mkdir -p $ROOT_PATH && sudo chown -R "$CURRENT_USER" "$ROOT_PATH"

if [ -d "$DOWNLOAD_PATH" ]; then
	echo 'Removing previously built version...[WAIT]'
	rm -fr $DOWNLOAD_PATH
	echo 'Removing previously built version...[DONE]'
fi

echo 'Downloading betterlockscreen...'
cd $ROOT_PATH && wget https://github.com/pavanjadhaw/betterlockscreen/archive/refs/heads/main.zip && unzip main.zip

sudo chmod u+x $DOWNLOAD_PATH/betterlockscreen

echo "Copying betterlockscreen to $BIN_PATH..."
sudo cp $DOWNLOAD_PATH/betterlockscreen $BIN_PATH

echo 'Copying betterlockscreen systemd unit file...'
sudo cp $DOWNLOAD_PATH/system/betterlockscreen@.service /etc/systemd/system

echo "Enabling betterlockscreen systemd service for user $CURRENT_USER..."
sudo systemctl enable betterlockscreen@"$CURRENT_USER"
