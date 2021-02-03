#!/bin/bash

# HOMEPAGE: https://dianne.skoll.ca/projects/remind/
set -e

clear
echo "This script is intended to be run as sudo...."
sleep 5

echo "Installing remind..."
ROOT=/opt
DOWNLOAD_DIR=$ROOT/installers/remind/src
COMPILE_DIR=$ROOT/src/remind
VERSION=03.03.05
mkdir -p $DOWNLOAD_DIR && cd $DOWNLOAD_DIR
wget https://dianne.skoll.ca/projects/remind/download/remind-$VERSION.tar.gz

mkdir -p $COMPILE_DIR
tar xfzv $DOWNLOAD_DIR/remind-$VERSION.tar.gz -C $COMPILE_DIR
cd $COMPILE_DIR/remind-$VERSION && ./configure && make & make install
# cp -farv $COMPILE_DIR/remind-$VERSION/src/remind /usr/bin
echo "Finished installing remind."
echo "Installing telegram-send..."
pip3 install telegram-send
echo "Finished installing telegram-send."
echo "DONE."
