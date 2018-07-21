These are the backups of the redash database as SQL.

The redash.env used when this data was backuped is as follows: 

# postgresql.
POSTGRES_USER=redash
PGPASSWORD=LyjnmgOTzepaC15dn
POSTGRES_DB=redash
TZ=Etc/UTC

# redash server
PYTHONUNBUFFERED=0
REDASH_LOG_LEVEL=INFO
REDASH_REDIS_URL=redis://redis:6379/0
REDASH_DATABASE_URL=postgresql://redash:LyjnmgOTzepaC15dn@postgres_redash/redash
REDASH_COOKIE_SECRET=pwmvjk6PiTS8cdovA
REDASH_WEB_WORKERS=4

# redash worker
QUEUES=queries,scheduled_queries,celery
WORKERS_COUNT=2

