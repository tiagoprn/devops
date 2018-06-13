#!/bin/bash

if [ -f redash.env ]; then
    echo 'File redash.env already exists, nothing to be done here.'
    exit 0
fi    

REDASH_COOKIE_SECRET=$(./random_password.sh)
PGPASSWORD=$(./random_password.sh)

cat << EOF > redash.env
# postgresql.
POSTGRES_USER=redash
PGPASSWORD=$PGPASSWORD
POSTGRES_DB=redash
TZ=Etc/UTC

# redash server
PYTHONUNBUFFERED=0
REDASH_LOG_LEVEL=INFO
REDASH_REDIS_URL=redis://redis:6379/0
REDASH_DATABASE_URL=postgresql://redash:$PGPASSWORD@postgres_redash/redash
REDASH_COOKIE_SECRET=$REDASH_COOKIE_SECRET
REDASH_WEB_WORKERS=4

# redash worker
QUEUES=queries,scheduled_queries,celery
WORKERS_COUNT=2
EOF

