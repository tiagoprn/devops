#!/bin/bash

PORTAINER=$(docker ps | grep portainer | awk '{print $1}')
if [ $PORTAINER  ] 
then
    printf 'Portainer is already running on port 9000, nothing to be done here.'
else    
    printf 'Starting portainer in the background...\n'
    cd /opt/containers/portainer && docker-compose up -d
    printf 'Portainer started. It can be reached through port 9000.'
fi
