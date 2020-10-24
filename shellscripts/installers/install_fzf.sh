#!/bin/bash

echo 'Run this script as sudo...'

# exit on error
set -e

INSTALLER_PATH=/opt/installers/fzf
mkdir -p $INSTALLER_PATH

VERSION=0.23.1

# https://github.com/junegunn/fzf/archive/0.23.1.tar.gz

wget -O $INSTALLER_PATH/fzf-$VERSION.tar.gz https://github.com/junegunn/fzf/archive/$VERSION.tar.gz

cd $INSTALLER_PATH && tar xfzv $VERSION.tar.gz

cd $INSTALLER_PATH/$VERSION && make && make install

echo "fzf sucessfully installed."
