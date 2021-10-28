#!/bin/bash

TRAEFIK=$(docker ps | grep traefik | awk '{print $1}')
PASSWORD=$(cat /opt/containers/traefik/admin.passwd)
if [ $TRAEFIK  ]
then
    printf 'traefik is already running, nothing to be done here.'
else
    printf 'Starting traefik in the background...\n'
    cd /opt/containers/traefik && \
        docker-compose up -d && \
        echo -e "Traefik started. It can be reached through:
            https://traefik.example.com, with user/password=traefik/$PASSWORD. "
fi

