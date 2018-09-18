- Use the generated password on the postgres superuser (postgres?) 

    $ psql -U postgres -p 5999 -c "ALTER USER postgres WITH PASSWORD '12345678';";

