#!/bin/bash

echo 'Run this script as sudo...'

# exit on error
set -e

INSTALLER_PATH=/opt/installers/nnn
mkdir -p $INSTALLER_PATH

DESTINATION_PATH=/usr/local/bin

VERSION=3.4

wget -O $INSTALLER_PATH/nnn-${VERSION}.tar.gz https://github.com/jarun/nnn/archive/v${VERSION}.tar.gz

cd $INSTALLER_PATH && tar xfzv nnn-${VERSION}.tar.gz

cd $INSTALLER_PATH/nnn-${VERSION} && make

cp $INSTALLER_PATH/nnn-${VERSION}/nnn $DESTINATION_PATH

echo "nnn sucessfully installed at $DESTINATION_PATH."
