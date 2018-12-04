#!/bin/bash

# Backup specific tables to sql files. It will backup just the data, so the
# tables should already be created on the destination database 
# for it to work as intended.

HOST="localhost"
PORT=5432
BACKUPS_ROOT="/backups"
UNIX_TIMESTAMP=$(date +%Y%m%d-%H%M%S-%N)
DUMPS_PATH="$BACKUPS_ROOT/sql/$UNIX_TIMESTAMP"

printf "When prompted, type PASSWORD: ${PGPASSWORD}\n"

mkdir -p $DUMPS_PATH

TABLES="01.organizations 02.users 03.groups 04.data_sources 05.data_source_groups 06.dashboards 07.queries 08.visualizations 09.widgets"

for table in $TABLES; do
        # below I split each table index.name into 2 variables, table and name
        set -- "$table";
        IFS="."; declare -a Array=($*);
        TABLE_ORDER=${Array[0]}
        TABLE_NAME=${Array[1]}

        echo ">>> Backing up ${TABLE_NAME} ...";

        pg_dump --host $HOST --port $PORT --no-owner --username $POSTGRES_USER --inserts --data-only -d redash -t $TABLE_NAME -f "$DUMPS_PATH/$TABLE_ORDER.$TABLE_NAME.sql";
done

tar cjfv $DUMPS_PATH.tar.bz2 $DUMPS_PATH 
rm -fr $DUMPS_PATH

