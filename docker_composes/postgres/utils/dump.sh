#!/bin/bash

HOST="localhost"
PORT=5432
FORMAT="c"
BACKUPS_ROOT="/backups"
DUMPS_PATH="$BACKUPS_ROOT/all"
FILE="$DUMPS_PATH/${POSTGRES_DB}.${FORMAT}.backup"
UNIX_TIMESTAMP=$(date +%Y%m%d-%H%M%S-%N)

printf "When prompted, type PASSWORD: ${PGPASSWORD}\n"

mkdir -p $DUMPS_PATH

# Makes the backup
pg_dump --host $HOST --port $PORT --username $POSTGRES_USER --role $POSTGRES_USER --format $FORMAT --verbose --file $FILE $POSTGRES_DB

# Uncompress the backup
tar cfzv $FILE.$UNIX_TIMESTAMP.tar.gz $FILE

# Moves the backup just uncompressed to BACKUPS_ROOT, so you always have the
# most recent backup there uncompressed for convenience.
mv $FILE $BACKUPS_ROOT
