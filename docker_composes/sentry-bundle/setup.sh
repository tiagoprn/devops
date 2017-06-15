#!/bin/bash

# Completely strip out the old containers and data
sudo docker-compose stop 
sudo docker-compose rm -f
sudo rm -fr data/

# Create certs for nginx
openssl req -x509 -nodes -days 3650 \
    -newkey rsa:2048 \
    -keyout nginx/sentry.key \
    -out nginx/sentry.crt

# Configure Sentry data directories

# Redis
if [ ! -d data/redis ] ; then
	mkdir -p data/redis
fi

# Postgres
if [ ! -d data/postgres/etc ] ; then
	mkdir -p data/postgres/etc
fi

if [ ! -d data/postgres/log ] ; then
	mkdir -p data/postgres/log
fi

if [ ! -d data/postgres/libdata ] ; then
	mkdir -p data/postgres/libdata
fi

