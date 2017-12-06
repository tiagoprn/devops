#!/bin/bash
rm -fr ~/.vim
rm -fr ~/.vimrc 
ln -s ~/dot_files/.vimrc ~/.vimrc
ln -s ~/dot_files/.vim ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
