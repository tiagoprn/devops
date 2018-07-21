## INITIAL IMPLEMENTATION

### redash
- Rerun the playbook
- Create the admin user as admin, with the email as devops@localhost.localdomain and
  password admin12345678.
- Create a script to restore the data from
  /storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash/database_queries_and_dashboards, 
so that I can have the dashboard pre_configured. IMPORTANT: maybe the tables
users, groups and organizations should not be restored at this point. 
- If the previous restoration worked, backup everything again so I can have the
  admin user stated as above. 
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

