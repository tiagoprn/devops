#!/bin/bash
set -e

REPOS="/storage/src/devops /storage/src/dot_files /storage/src/bin_private /storage/docs/notes /storage/src/tiagoprnl /storage/src/gpg /storage/src/dwm /storage/src/dwmblocks /storage/src/st /storage/src/reminders /storage/docs/fleeting-notes"
UPDATE_BRANCH=master

for repo in $REPOS; do
	echo -e '-----'
	echo " >>> Updating repository '$repo' (branch $UPDATE_BRANCH)..."
	cd $repo && git fetch && git checkout $UPDATE_BRANCH && git pull origin $UPDATE_BRANCH
done

echo -e '-----'

echo "FINISHED."
