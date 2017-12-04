#!/bin/bash
echo 'Killing all running containers...'
docker ps | awk '{print $1}' | xargs docker kill
echo ' DONE.'
