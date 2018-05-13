#!/bin/bash
BACKUPS_ROOT="/backups"

##### FULL DATABASE #####
pg_restore --host localhost --port 5432 --username $POSTGRES_USER --dbname $POSTGRES_DB --clean --role $POSTGRES_USER -W --jobs 1 --verbose $BACKUPS_ROOT/$POSTGRES_DB.c.backup
