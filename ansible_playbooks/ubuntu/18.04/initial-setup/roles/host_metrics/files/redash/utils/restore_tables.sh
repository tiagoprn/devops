#!/bin/bash

# Restore specific tables from sql files. The tables should already be created 
# on the database for it to work as intended.

# This script has potential to be destructive if the tables you wish to 
# populate already has data. If so, make sure to do a proper backup before 
# running it.

HOST="localhost"
PORT=5432
DUMPS_PATH="/shared/database_queries_and_dashboards"

printf "If prompted for a password, type: ${PGPASSWORD}\n"

TABLES="01.organizations 02.users 03.groups 04.data_sources 05.data_source_groups 06.dashboards 07.queries 08.visualizations 09.widgets"
# TABLES="04.data_sources 05.data_source_groups 06.dashboards 07.queries 08.visualizations 09.widgets"

for table in $TABLES; do
        # below I split each table index.name into 2 variables, table and name
        set -- "$table";
        IFS="."; declare -a Array=($*);
        TABLE_ORDER=${Array[0]}
        TABLE_NAME=${Array[1]}

        echo ">>> Restoring ${TABLE_NAME} ...";

        psql --host $HOST --port $PORT --username $POSTGRES_USER --dbname redash < "$DUMPS_PATH/$TABLE_ORDER.$TABLE_NAME.sql"

done

