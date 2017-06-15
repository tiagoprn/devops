#!/bin/bash

/project_virtualenv/bin/uwsgi --chdir /path/to/django_project --http :9000 --wsgi-file /path/to/django_project/django_project/wsgi_nginx.py;

