#!/bin/bash

# Below is for te virtualenv management through this shell script to work
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

CURRENT_DIR_NAME=${PWD##*/}

if [[ -z $PYENV_VERSION ]]; then
    echo "No virtualenv is activated.";
else
    echo "Current activated virtualenv: $PYENV_VERSION"
    echo 'Deactivating the virtualenv...'
    pyenv deactivate;
fi

echo "Deleting the virtualenv $CURRENT_DIR_NAME..."
pyenv uninstall -f $CURRENT_DIR_NAME;
rm -fr ~/.pyenv/versions/$CURRENT_DIR_NAME ~/.pyenv/versions/3.7.0/envs/$CURRENT_DIR_NAME/

echo "Creating the virtualenv $CURRENT_DIR_NAME..."
pyenv virtualenv 3.7.0 $CURRENT_DIR_NAME && pyenv activate $CURRENT_DIR_NAME

echo 'Upgrading pip...';
pip install --upgrade pip

echo 'Installing requirements...';
pip install --no-cache-dir -r requirements
pyenv rehash

echo "DONE. Activating virtualenv $CURRENT_DIR_NAME..."
pyenv activate $CURRENT_DIR_NAME

