# postgres

Setup a PostgreSQL 10 instance on a CentOS 7 server. 

It is recommended you run first the `initial-setup` playbook to provisionate
the server. 

PostgreSQL listens on all interfaces, on port 5999.

Reference: https://www.vivaolinux.com.br/dica/FreeRADIUS-PostgreSQL-10

## Instructions

### How to run a query interactively, using the user password:

    $ PGPASSWORD='12345678' psql -h 10.0.5.31 -U postgres -p 5999 -c "\l";

### Getting the postgres user password: 

    The password is shown to you when you run the playbook. But in the case you
forget it, it was also copied to `/root/postgresql.admin.passwd`.
 
