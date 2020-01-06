#!/bin/bash

PYENV_ROOT="$HOME/.pyenv"
PYENV_BIN=$PYENV_ROOT/bin/pyenv

if [ -f $PYENV_BIN ];
then
    echo "UPGRADING pyenv..."
    echo "Retrieving available tags:"
    cd $PYENV_ROOT && git fetch && git tag | grep "v[1-9]\."
    echo "Now, you must do a "git checkout" on the last tag."
    # git checkout $(git tag)
    echo "FINISHED."
else
    echo "INSTALLING pyenv..."
    git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
    echo "If you installed from other source than this repository, apply the changes from my files
    .bash_environment (PYENV named environment variables) and .bashrc (pyenv initialization) to your
    .bashrc."
    echo "FINISHED. Quit this shell or start another one now."
fi
