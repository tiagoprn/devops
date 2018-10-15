#!/bin/bash
echo 'Deleting and recreating the virtualenv...'
pyenv deactivate;
pyenv uninstall -f utils; 
rm -fr ~/.pyenv/versions/utils ~/.pyenv/versions/3.7.0/envs/utils/
pyenv virtualenv 3.7.0 utils && pyenv activate utils

echo 'Upgrading pip...';
pip install --upgrade pip
echo 'Installing requirements...';
pip install --no-cache-dir -r requirements
pyenv rehash
echo 'DONE'
