- The container is called `postgres_notepy`. Edit it to your wish. 
- `postgres.env` contains the credentials to create the database.
- `utils/` contains scripts to dump and restore the database, with some
  environment variables hardcoded there also.
- According to
  https://stackoverflow.com/questions/19674456/run-postgresql-queries-from-the-command-line,
if you set the enviroment variable PGPASSWORD you do not need to inform your
password.

