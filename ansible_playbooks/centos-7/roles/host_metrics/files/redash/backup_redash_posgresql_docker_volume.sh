#!/bin/bash
BACKUP_PATH=/opt/containers/backups/docker_volumes/redash_postgres
mkdir -p $BACKUP_PATH 
./docker_volume_backup.sh docker-compose.yml postgres $BACKUP_PATH backup 

