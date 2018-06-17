## INITIAL IMPLEMENTATION

### redash

- Create the admin user as admin, with the email as devops@localhost and
  password admin.
- Create the tasks to copy the redash container and start them on the playbook.
  Te copy command is not working, says `files/redash` do not exist. Check why.
- Configure the host dashboards on redash (pointing to the influxdb database)
- After the host dashboards configured, make a backup of the postgres database and
  put it on `roles/host_metrics/files`, and include in the playbook a task to
restore this backup so that the dashboard can come up preconfigured.
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

