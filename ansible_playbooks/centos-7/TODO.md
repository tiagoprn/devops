## INITIAL IMPLEMENTATION
- Output the influxdb password as a file to `/root`, with the other files.
- Migrate the role to run portainer to a docker-compose file, generate the
  systemd unit files and use it as a starting point to generate the redash containers later on.
- Install and make redash work - backup its postgresql docker volume into this
  repository, so it contains the dashboards configured.
- After redash working, remove grafana (since redash can read influx
  databases). 

## FUTURE ENHANCEMENTS
- Find a way to aggregate all logs into a single place as JSON to later be consolidated on elasticsearch using something like... logstash? 

