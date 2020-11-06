#!/bin/bash
set -e

VERSION='1.21.2'
DOWNLOAD_PATH='/usr/bin/docker-compose'
BACKUP_PATH="$DOWNLOAD_PATH.bkp.$(date +%Y%m%d-%H%M%S-%N)"

echo -e 'Current version:'
docker-compose --version

echo -e 'Backing up current version...'
sudo cp -farv $DOWNLOAD_PATH $BACKUP_PATH

echo -e "Downloading version $VERSION..."
sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` -o $DOWNLOAD_PATH

echo -e 'Fixing permissions...'
sudo chmod +x $DOWNLOAD_PATH

echo -e 'Successfully installed. New version:'
docker-compose --version

echo -e "If needed, a backup is available at $BACKUP_PATH."
