## INITIAL IMPLEMENTATION

### redash
- Restore the data from
  /storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash/shared/database_queries_and_dashboards, 
so that I can have the dashboard pre_configured. Add dashboards for the
following metrics (enabled yesterday): 

(The admin user e-mail is devops@localhost.localdomain and password admin12345678.)

interface_rx
interface_tx
processes_majflt
processes_minflt
processes_processes
processes_read
processes_rx
processes_syst
processes_threads
processes_tx
processes_user
processes_value
processes_write
tcpconns_value

- Backup the redash postgresql database after adding the new queries (pay
  attention to change xx.queries.sql to set the column 7 as NULL - before the
column "name" - find a way to automate this too)  

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

