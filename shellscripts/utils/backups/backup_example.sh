#!/bin/bash

# Backup all shell scripts on /storage/src, cleaning up backups older than 3
# days.

DESTINATION="/storage/backups"
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
BACKUP_FILE=$DESTINATION/shellscripts.$TIMESTAMP.tar.bz2

echo 'Deleting backups older than 3 days...'
find $DESTINATION -name "*.tar.bz2" -mtime +3 | while read fname; do
    rm -fr $fname;
    echo "on: $(date +%Y%m%d_%H%M%S), deleted: $fname"
done

echo 'Backing up the files...'
tar cfjv $BACKUP_FILE /storage/src/*.sh

echo "Finished backup on $BACKUP_FILE."
