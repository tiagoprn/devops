#!/bin/bash

# limit-as is the maximum address space in memory in MB that will be allowed to the number of processes you parameterized
/project_virtualenv/bin/uwsgi --chdir /path/to/django_project --socket 127.0.0.1:9000 --daemonize /path/to/django_project/log/uwsgi.log --logdate --pidfile /tmp/uwsgi-django_project.pid --vacuum --max-requests 100 --die-on-term --master --limit-as 1024 --processes 2 --wsgi-file /path/to/django_project/django_project/wsgi_nginx.py;

