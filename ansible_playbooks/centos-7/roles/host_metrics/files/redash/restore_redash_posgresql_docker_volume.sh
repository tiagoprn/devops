#!/bin/bash

BACKUP_PATH=/opt/containers/backups/docker_volumes/redash_postgres

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            restore_date)              RESTORE_DATE=${VALUE} ;;
            *)   
    esac    
done

if [ ! "$RESTORE_DATE" ]; then
    echo "You must specify the restore_date. E.g.: restore_date=2016-05-30"
    exit 1;
fi

echo "Will restore backup from date $RESTORE_DATE..."

mkdir -p $BACKUP_PATH 
./docker_volume_backup.sh docker-compose.yml postgres $BACKUP_PATH restore $RESTORE_DATE

