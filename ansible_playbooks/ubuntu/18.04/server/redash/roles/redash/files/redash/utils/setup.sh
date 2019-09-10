#!/bin/bash
sleep 5;  # wait for the container to start to run the commands
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "ALTER ROLE $POSTGRES_USER SET client_encoding TO 'utf8';"
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "ALTER ROLE $POSTGRES_USER SET default_transaction_isolation TO 'read committed';"
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "ALTER ROLE $POSTGRES_USER SET timezone TO 'UTC';"
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;"
