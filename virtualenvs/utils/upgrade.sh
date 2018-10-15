#!/bin/bash
echo 'Upgrading pip...';
pip install --upgrade pip
echo 'Checking for updates...'
pip list -o 

# echo 'Updating all installed packages...'
# pip install -U $(pip freeze | awk '{split($0, a, "=="); print a[1]}')
pyenv rehash
echo 'DONE'
