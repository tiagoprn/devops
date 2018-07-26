## INITIAL IMPLEMENTATION

### redash

- Adicionar instruções no README de como rodar o stress-ng.  

ex.: $ stress-ng --cpu 1 --vm 1 --hdd 1 --fork 1 --switch 1 --timeout 10 --metrics 

- include in the playbook a task to
restore the backup so that the dashboard can come up preconfigured (use
files/redash/database_queries_and_dashboards/04.data_sources.sql.j2 for this
table, there is a script on the same folder that generates it).

- Add another step to the start_containers/redash task and make it restore the
  postgresql backup created. Add a message after the playbook execution and at  
the documentation that I should change the admin user email and password 
manually after the steps are completed.

- Create a self-signed SSL certificate and setup it on the nginx configuration.

- After finishing, move
  `/storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash`
to my other repository `/storage/src/devops/docker_composes/redash`, since the
redash configuration will be battle-tested. ;) 

## FUTURE ENHANCEMENTS
- Find a way to aggregate all logs into a single place as JSON to later be consolidated on elasticsearch using something like... logstash? 

