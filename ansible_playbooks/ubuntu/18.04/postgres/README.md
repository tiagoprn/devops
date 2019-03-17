# postgres

Setup a PostgreSQL 10 instance on a Ubuntu 18.04 server.

It is recommended you run first the `initial-setup` playbook to provisionate
the server.

We keep the `postgres` user intact and without a password, since it is required to run automation, replication and other administrative tasks.
Below is an example:

    $ sudo -u postgres psql -c '\l'

This user only has permission to access the database locally, and it should be kept that way.
Ideally, for security reasons, we recomend you to create a user for each database to keep them isolated.





-----


## Instructions

### How to run a query interactively, using the user password:

    $ PGPASSWORD='12345678' psql -h 10.0.5.31 -U postgres -p 5999 -c "\l";

### Getting the postgres user password:

    The password is shown to you when you run the playbook. But in the case you
forget it, it was also copied to `/root/postgresql.admin.passwd`. It is also
stored as a "fact" into ansible host facts, so I can run my custom
`ansible-facts` command and grep for `postgres` to get its value on the CLI -
and it also allows it to be directly used by other playbooks.



