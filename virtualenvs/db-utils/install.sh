#!/bin/bash

CURRENT_DIR_NAME=${PWD##*/}

echo "Deleting and recreating the virtualenv $CURRENT_DIR_NAME..."
pyenv deactivate;
pyenv uninstall -f $CURRENT_DIR_NAME;
rm -fr ~/.pyenv/versions/$CURRENT_DIR_NAME ~/.pyenv/versions/3.7.0/envs/$CURRENT_DIR_NAME/
pyenv virtualenv 3.7.0 $CURRENT_DIR_NAME && pyenv activate $CURRENT_DIR_NAME

echo 'Upgrading pip...';
pip install --upgrade pip
echo 'Installing requirements...';
pip install --no-cache-dir -r requirements
pyenv rehash
pyenv activate $CURRENT_DIR_NAME
echo 'DONE'
