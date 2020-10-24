#!/bin/bash

# TODO: upgrade to tmux 3.x, test on kvm with ubuntu 18.

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

INSTALLER_PATH=/opt/installers/nnn
mkdir -p $INSTALLER_PATH

VERSION=3.4

# wget -O $INSTALLER_PATH/nnn-${VERSION}.tar.gz https://github.com/jarun/nnn/archive/v${VERSION}.tar.gz

cd /opt/installers/nnn && tar xfzv nnn-${VERSION}.tar.gz


echo "nnn sucessfully installed at ."
