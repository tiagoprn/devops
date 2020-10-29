#!/bin/bash

echo 'Run this script as sudo...'

# exit on error
set -e

INSTALLER_PATH=/opt/installers/fzf
mkdir -p $INSTALLER_PATH

VERSION=0.23.1

wget -O $INSTALLER_PATH/fzf-$VERSION.tar.gz https://github.com/junegunn/fzf/archive/$VERSION.tar.gz

cd $INSTALLER_PATH && tar xfzv fzf-$VERSION.tar.gz

cd $INSTALLER_PATH/fzf-$VERSION && make && make install

cp $INSTALLER_PATH/fzf-$VERSION/bin/* /usr/local/bin

echo "fzf sucessfully installed."
