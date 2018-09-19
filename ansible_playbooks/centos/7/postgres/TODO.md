- Configure files/pg_hba.conf to allow IP connections with password 
(https://pt.wikibooks.org/wiki/PostgreSQL_Pr%C3%A1tico/Configura%C3%A7%C3%B5es/Configurar_acessos)

- Use the generated password on the postgres superuser.

How to programatically set a user's password through psql:
    $ psql -U postgres -p 5999 -c "ALTER USER postgres WITH PASSWORD '12345678';";

- How to test a connection by IP to the postgresql instance is working: 
    $ psql -h 10.0.5.43 -U postgres -p 5999 -c "\l";
    
