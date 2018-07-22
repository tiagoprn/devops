## INITIAL IMPLEMENTATION

### redash
- Restore the data from
  /storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash/shared/database_queries_and_dashboards, 
so that I can have the dashboard pre_configured. Enable the disk plugin (https://collectd.org/wiki/index.php/Plugin:Disk) and put
its data on a redash dashboard.

- Backup the redash postgresql database after adding the new queries and copy
  it to this repository on files/redash/shared (run roles/host_metrics/files/redash/shared/database_queries_and_dashboards/replace_7th_column_foreign_key_with_null.py 
  to change 07.queries.sql to set the column 7 as NULL - before the column "name")  

- instalar o stress-ng para permitir fazer o benchmark do container e ver os
  grãficos no redash. Criar shellscripts separados para testar memõria, cpu,
disco e rede. 

- include in the playbook a task to
restore this backup so that the dashboard can come up preconfigured. Turn the
file files/redash/database_queries_and_dashboards/04.data_sources.sql into a
jinja template, to change the host ip and the password to the ones created on
the playbook. 

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

