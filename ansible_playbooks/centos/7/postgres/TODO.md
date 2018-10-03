- Use the generated password on the postgres superuser.

How to programatically set a user's password through psql:
    $ psql -U postgres -p 5999 -c "ALTER USER postgres WITH PASSWORD '12345678';";

- How to test a connection by IP to the postgresql instance is working: 
    $ PGPASSWORD='12345678' psql -h 10.0.5.31 -U postgres -p 5999 -c "\l";
    
