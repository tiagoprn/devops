#!/bin/bash
PYENV_ROOT=$HOME/.pyenv
echo "Renaming existing $PYENV_ROOT..."
mv $PYENV_ROOT $HOME/.pyenv.$(date "+%Y%m%d.%H%M.%S")
echo 'Cloning pyenv git repo...'
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'Cloning pyenv-virtualenv repo...'
git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv

