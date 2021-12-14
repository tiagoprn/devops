#!/bin/bash

# IMPORTANT: this script was originally developed for ubuntu 20.04.

DOWNLOAD_PATH='/opt/nvim'
APP_IMAGE_NAME='nvim.appimage'
BACKUP_PATH="$DOWNLOAD_PATH/OLD/$APP_IMAGE_NAME.bkp.$(date +%Y%m%d-%H%M%S-%N)"

sudo mkdir -p $DOWNLOAD_PATH/OLD

echo -e 'Current version:'
nvim --version || true

echo -e 'Backing up current version...'
sudo cp -farv "$DOWNLOAD_PATH/$APP_IMAGE_NAME" "$BACKUP_PATH" || true

echo -e 'Closing all nvim running instances in 5 seconds...'
sleep 5
sudo pkill nvim

echo -e "Downloading into '$DOWNLOAD_PATH/$APP_IMAGE_NAME'..."
sudo curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o "$DOWNLOAD_PATH/$APP_IMAGE_NAME"

echo -e 'Fixing permissions...'
sudo chmod 777 $DOWNLOAD_PATH/$APP_IMAGE_NAME

echo -e 'Successfully installed. New version:'
nvim --version

echo -e "If needed, the old nvim app image is available at $BACKUP_PATH."
