#!/bin/bash
set -e

for repo in $REPOS; do
	echo -e '-----'
	echo " >>> Updating repository '$repo'..."
	cd /storage/src/$repo && git fetch && git checkout $UPDATE_BRANCH && git pull
done

echo -e '-----'

echo "FINISHED."
