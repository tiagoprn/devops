#!/bin/bash
echo 'Killing docker container... '
docker ps | grep traefik | awk '{print $1}' | xargs docker kill
echo 'DONE!'
