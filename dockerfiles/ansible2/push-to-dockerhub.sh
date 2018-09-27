#!/bin/bash
NEWVERSION=20180927-3
docker ps | grep ansible | awk '{print $1}' | xargs docker kill
docker build -t tiagoprn/ansible2:$NEWVERSION .
docker run -t tiagoprn/ansible2:$NEWVERSION tail -f /dev/null &
docker commit -m "Updating to new version." -a "tiagoprn" $(docker ps | grep ansible | awk '{print $1}') tiagoprn/ansible2:$NEWVERSION
docker push tiagoprn/ansible2
