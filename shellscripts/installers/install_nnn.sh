#!/bin/bash

# TODO: upgrade to tmux 3.x, test on kvm with ubuntu 18.

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

INSTALLER_PATH=/opt/installers/nnn
sudo mkdir -p $INSTALLER_PATH

VERSION=3.4

# download source files for tmux, libevent, and ncurses
# wget -O tmux-${TMUX_VERSION}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz/download
sudo wget -O $INSTALLER_PATH/nnn-${VERSION}.tar.gz https://github.com/jarun/nnn/archive/v${VERSION}.tar.gz

# cleanup
rm -rf $HOME/tmux_tmp

echo "nnn sucessfully installed at ."
