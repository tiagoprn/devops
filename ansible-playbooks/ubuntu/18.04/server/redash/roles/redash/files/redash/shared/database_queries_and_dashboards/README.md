These are the backups of the redash database as SQL.

The file 07.queries.sql must always be processed so that the 7th column
contains the value NULL, for the database to be successfully restored. To do
that, after copying the backup to here, run the following command: 

    $ python replace_7th_column_foreign_key_with_null.py

To login on redash, you must use the following credentials: 

user: devops
email: devops@localhost.localdomain
password: admin12345678

After logged in, it is highly recommended you change this users's password to a more secure one.

