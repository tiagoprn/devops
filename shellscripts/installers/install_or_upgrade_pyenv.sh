#!/bin/bash

# Created with instructions from:
# https://github.com/pyenv/pyenv#basic-github-checkout
# https://github.com/pyenv/pyenv-virtualenv
# https://github.com/pyenv/pyenv-installer/issues/112#issuecomment-971964711
# IMPORTANT: if anything goes wrong, make sure to check those links above for updated instructions
#            (specially if pyenv virtualenvs stop working - it will probably be related to ~/.bashrc).

# About pyenv and shims:
# https://mungingdata.com/python/how-pyenv-works-shims/?utm_source=pocket_mylist
# https://stackoverflow.com/questions/2116142/what-is-a-shim?ref=hackernoon.com


BASH_RC_PATH=$HOME/.bashrc

PYENV_ROOT_FOLDER="$HOME/.pyenv"
PYENV_BIN=$PYENV_ROOT_FOLDER/bin/pyenv

BACKUP_FILE_SUFFIX=".BACKUP.$(date +%Y%m%d-%H%M%S-%N)"


if [ -f $PYENV_BIN ];
then

	echo "UPGRADING pyenv (from master branch)..."
	cd $PYENV_ROOT_FOLDER && git fetch && git pull && git checkout master

	echo "UPGRADING pyenv-virtualenv (from master branch)..."
	cd $PYENV_ROOT_FOLDER/plugins/pyenv-virtualenv && git fetch && git pull && git checkout master

	echo "FINISHED. If your pyenv/pyenv-virtualenv stops working, delete $PYENV_ROOT_FOLDER and run this script again."

else
	echo -e "Make sure you have the following packages installed on ubuntu or debian-base distros: \n"
	echo -e "\t sudo apt install -y git build-essential python3-dev libssl-dev libbz2-dev libreadline-dev sqlite3 vim libsqlite3-dev"

	sleep 5

	echo "INSTALLING pyenv..."

	git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT_FOLDER
	git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT_FOLDER/plugins/pyenv-virtualenv

	echo "The steps below will change $BASH_RC_PATH. I will backup its' original contents to make sure you can revert their contents if you need it..."
	cp -fav "$BASH_RC_PATH" "$BASH_RC_PATH.$BACKUP_FILE_SUFFIX"
	echo "Original bash config file successfully backed up at: $BASH_RC_PATH.$BACKUP_FILE_SUFFIX"

	echo "Updating $BASH_RC_PATH, so that pyenv/pyenv-virtualenv work..."

	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $BASH_RC_PATH
	echo 'export PATH="$PATH:$PYENV_ROOT/bin"' >> $BASH_RC_PATH
	echo 'eval "$(pyenv init --path)"' >> $BASH_RC_PATH
	echo 'eval "$(pyenv init -)"' >> $BASH_RC_PATH
	echo 'eval "$(pyenv virtualenv-init -)"' >> $BASH_RC_PATH


	echo "Open $BASH_RC_PATH and make sure there are no duplicate entries related to pyenv init/pyenv-virtualenv init on the files."
	sleep 5
	echo "FINISHED. Quit this shell or start another one now."
fi
