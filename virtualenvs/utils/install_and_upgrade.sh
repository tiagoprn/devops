#!/bin/bash
echo 'Upgrading pip...';
pip install --upgrade pip
echo 'Installing requirements...';
pip install -r requirements
echo 'Updating all installed packages...'
pip install -U $(pip freeze | awk '{split($0, a, "=="); print a[1]}')
echo 'DONE'
