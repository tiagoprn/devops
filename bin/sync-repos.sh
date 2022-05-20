#!/bin/bash
set -e

REPOS="/storage/src/devops /storage/src/dot_files /storage/src/bin_private /storage/docs/notes /storage/src/tiagoprnl /storage/src/gpg /storage/src/reminders /storage/docs/fleeting-notes /storage/src/iac /storage/src/pass /storage/src/code-insights"

UPDATE_BRANCH=master

for repo in $REPOS; do
	if [ -d "$repo" ]; then
		echo -e '-----'
		echo " >>> Updating repository '$repo' (branch $UPDATE_BRANCH)..."
		cd $repo && git fetch && git checkout $UPDATE_BRANCH && git pull origin $UPDATE_BRANCH
	else
		echo -e '-----'
		echo "Repository not checked into "$repo", moving on to the next..."
	fi
done

echo -e '-----'

echo "FINISHED."
