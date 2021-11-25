#!/bin/bash
echo 'Killing docker container... '
docker ps | grep portainer | awk '{print $1}' | xargs docker kill
echo 'DONE!'
