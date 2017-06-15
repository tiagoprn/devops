#!/bin/bash
HOST="localhost"
PORT=5432
USERNAME="tmc"
PASSWORD="v3t3x2y2"
DATABASE="tmc_financeiro"
ROLE=$USERNAME
FORMAT="c"
FILE="/utils/postgres/dumps/${DATABASE}.${FORMAT}.backup"

UNIX_TIMESTAMP=$(date +%Y%m%d-%H%M%S-%N)

printf "When prompted, type PASSWORD: ${PASSWORD}\n"
pg_dump --host $HOST --port $PORT --username $USERNAME --role $ROLE --format $FORMAT --verbose --file $FILE $DATABASE
tar cfzv $FILE.FROM_PRODUCTION_TMCV2.$UNIX_TIMESTAMP.tar.gz $FILE
mv $FILE /utils/postgres
