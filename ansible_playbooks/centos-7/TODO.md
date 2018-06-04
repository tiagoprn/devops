## INITIAL IMPLEMENTATION

### redash

- Create a shell script to stop all the containers (using docker-compose stop) 
- Create a shell script to make a backup of the docker volume that contains the
  postgresql data
- Create a shell script to restore the backup of the docker volume that
  contains the postgresql data 
- Configure the host dashboards on redash (pointing to the influxdb database)
- After the host dashboards configured, make a backup of the docker volume and
  put it on `roles/host_metrics/files`, and include in the playbook a task to
restore this volume so that the dashboard can come up preconfigured.
- Create a self-signed SSL certificate and setup it on the nginx configuration.

## FUTURE ENHANCEMENTS
- Find a way to aggregate all logs into a single place as JSON to later be consolidated on elasticsearch using something like... logstash? 

