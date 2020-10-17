#!/bin/bash

# TODO: upgrade to tmux 3.x, test on kvm with ubuntu 18.

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION=3.2
# set below to a blank string if the version is not RC
IS_RC='-rc'
RC_VERSION='-rc2'

# create our directories
mkdir -p $HOME/local/bin $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
# wget -O tmux-${TMUX_VERSION}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz/download
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}${IS_RC}/tmux-${TMUX_VERSION}${RC_VERSION}.tar.gz

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}${RC_VERSION}
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
cp tmux $HOME/local/bin
cd ..

# cleanup
rm -rf $HOME/tmux_tmp

echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."
