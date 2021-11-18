#!/bin/bash

# Created with instructions from:
# https://github.com/pyenv/pyenv#basic-github-checkout
# https://github.com/pyenv/pyenv-virtualenv
# IMPORTANT: if anything goes wrong, make sure to check those links above for updated instructions
#            (specially if pyenv virtualenvs stop working - it will probably be related to ~/.profile and/or ~/.bashrc).

BASH_PROFILE_PATH=$HOME/.profile
BASH_RC_PATH=$HOME/.bashrc

PYENV_ROOT_FOLDER="$HOME/.pyenv"
PYENV_BIN=$PYENV_ROOT_FOLDER/bin/pyenv

if [ -f $PYENV_BIN ];
then

	echo "UPGRADING pyenv (from master branch)..."
	cd $PYENV_ROOT_FOLDER && git fetch && git pull && git checkout master

	echo "UPGRADING pyenv-virtualenv (from master branch)..."
	cd $PYENV_ROOT_FOLDER/plugins/pyenv-virtualenv && git fetch && git pull && git checkout master

	echo "FINISHED. If your pyenv/pyenv-virtualenv stops working, delete $PYENV_ROOT_FOLDER and run this script again."

else
	echo "Make sure you have the following packages installed on ubuntu or debian-base distros: \n"
	echo "\t sudo apt install -y git build-essential python3-dev libssl-dev libbz2-dev libreadline-dev sqlite3 vim libsqlite3-dev"

	sleep 5

	echo "INSTALLING pyenv..."

	git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT_FOLDER
	git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT_FOLDER/plugins/pyenv-virtualenv

	echo "The steps below will change $BASH_RC_PATH and $BASH_PROFILE_PATH. I will backup their original contents to make sure you can revert their contents if you need it..."
	cp -fav "$BASH_PROFILE_PATH" "$BASH_PROFILE_PATH.ORIG"
	cp -fav "$BASH_RC_PATH" "$BASH_RC_PATH.ORIG"
	echo "Original bash config files successfully backed up."

	echo "Updating $BASH_PROFILE_PATH and $BASH_RC_PATH configuration, so that pyenv/pyenv-virtualenv work..."
	# the sed invocation inserts the lines at the start of the file after any initial comment lines
	sed -Ei -e '/^([^#]|$)/ {a \
		export PYENV_ROOT="$HOME/.pyenv"
	a \
		export PATH="$PYENV_ROOT/bin:$PATH"
	a \
		' -e ':a' -e '$!{n;ba};}' $BASH_PROFILE_PATH
		echo 'eval "$(pyenv init --path)"' >> $BASH_PROFILE_PATH
		echo 'eval "$(pyenv init -)"' >> $BASH_RC_PATH
	echo 'eval "$(pyenv virtualenv-init -)"' >> $BASH_RC_PATH

	echo "Open $BASH_RC_PATH and $BASH_PROFILE_PATH and make sure there are no duplicate entries related to pyenv init/pyenv-virtualenv init on the files."
	sleep 5
	echo "FINISHED. Quit this shell or start another one now."

fi
