This installs collectd (with a plugin to collect information from vmstat),
influxdb to store the metrics and grafana to present them beautifully. 

grafana.ini is generated from a jinja2 template, since the password will be
randomically generated. 

To login on grafana, you must use the following credentials: 

URL: [vm_host]:3000
USER: admin
PASSWORD: [check grafana.ini: $ sudo cat /etc/grafana/grafana.ini | grep admin_password) 
