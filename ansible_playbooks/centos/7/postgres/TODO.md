- Habilitar o firewall-cmd na porta 5999 do postgres via firewalld: 
    $ firewall-cmd --permanent --zone=public --add-port=5999/tcp && firewall-cmd --reload
  (ver como fazer os comandos acima usando o ansible module firewalld:
https://docs.ansible.com/ansible/2.5/modules/firewalld_module.html)  

- Configure files/pg_hba.conf to allow IP connections with password 
(https://pt.wikibooks.org/wiki/PostgreSQL_Pr%C3%A1tico/Configura%C3%A7%C3%B5es/Configurar_acessos)

- Use the generated password on the postgres superuser.

How to programatically set a user's password through psql:
    $ psql -U postgres -p 5999 -c "ALTER USER postgres WITH PASSWORD '12345678';";

- How to test a connection by IP to the postgresql instance is working: 
    $ psql -h 10.0.5.43 -U postgres -p 5999 -c "\l";
    
