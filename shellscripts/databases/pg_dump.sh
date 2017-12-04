#!/bin/bash
HOST="localhost"
PORT=5432
USERNAME="tmc"
PASSWORD="v3t3x2y2"
DATABASE="tmc_financeiro"
ROLE=$USERNAME
FORMAT="c"
FILE="${DATABASE}.${FORMAT}.backup"

UNIX_TIMESTAMP=$(date +%s)

printf "When prompted, type PASSWORD: ${PASSWORD}\n"
pg_dump --host $HOST --port $PORT --username $USERNAME --role $ROLE --format $FORMAT --verbose --file $FILE $DATABASE
tar cfjv $FILE.$UNIX_TIMESTAMP.tar.bz2 $FILE
rm $FILE
