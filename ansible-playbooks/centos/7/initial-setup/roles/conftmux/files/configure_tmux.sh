#!/bin/bash
if [ ! -d ~/.tmux ]; then 
    mkdir ~/.tmux
    ln -s ~/dot_files/.tmux.conf ~/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
