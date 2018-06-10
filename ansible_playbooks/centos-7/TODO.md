## INITIAL IMPLEMENTATION

### redash

- Generate an ansible jinja2 template of redash.env, changing the values of 
  `REDASH_COOKIE_SECRET`, `POSTGRES_PASSWORD` and `REDASH_DATABASE_URL` and
recording the file at /opt/containers/redash.
- Configure the host dashboards on redash (pointing to the influxdb database)
- After the host dashboards configured, make a backup of the postgres database and
  put it on `roles/host_metrics/files`, and include in the playbook a task to
restore this backup so that the dashboard can come up preconfigured.
- Create a self-signed SSL certificate and setup it on the nginx configuration.
- After finishing, move
  `/storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash`
to my other repository `/storage/src/devops/docker_composes/redash`, since the
redash configuration will be battle-tested. ;) 

## FUTURE ENHANCEMENTS
- Find a way to aggregate all logs into a single place as JSON to later be consolidated on elasticsearch using something like... logstash? 

