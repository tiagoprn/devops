#!/bin/bash
# reference: http://blog.stefanxo.com/2014/02/clean-up-after-docker/

echo 'Removing temporary built images... [WAIT]'
docker images --no-trunc| grep none | awk '{print $3}' | xargs -r docker rmi
echo 'Removing temporary built images... [DONE]'

echo 'Removing Docker containers with Exit status... [WAIT]'
docker ps -a --no-trunc | grep 'Exit' | awk '{print $1}' | xargs -r docker rm
echo 'Removing Docker containers with Exit status... [DONE]'

echo 'Removing orphaned docker volumes (from removed containers)... [WAIT]'
docker volume rm $(docker volume ls -qf dangling=true)
echo 'Removing orphaned docker volumes (from removed containers)... [DONE]'

