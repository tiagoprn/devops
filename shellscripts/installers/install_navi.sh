#!/bin/bash
DOWNLOAD_PATH=~/tmp/navi
INSTALL_PATH=~/bin

git clone --depth 1 https://github.com/denisidoro/navi $DOWNLOAD_PATH
cd $DOWNLOAD_PATH
./scripts/install $INSTALL_PATH
