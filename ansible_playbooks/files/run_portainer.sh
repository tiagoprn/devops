#!/bin/bash


if [ -f  /root/portainer.admin.passwd ]
then
    printf 'The portainer admin password was already generated, nothing to be done here.'
else    
    printf 'Generating portainer admin passwd...\n'
    date | md5sum | awk '{print $1}' > /root/portainer.admin.passwd
    printf 'Encrypting the generated admin passwd...\n'
    docker run --rm httpd:2.4-alpine htpasswd -nbB admin $(cat /root/portainer.admin.passwd) | cut -d ":" -f 2 > /root/portainer.admin.encrypted
    printf 'Done. The portainer admin passwd is at "/root/portainer.admin.passwd".\n'
fi

PORTAINER=$(docker ps | grep portainer | awk '{print $1}')
if [ $PORTAINER  ] 
then
    printf 'Portainer is already running on port 9000, nothing to be done here.'
else    
    printf 'Starting portainer in the background...\n'
    docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /etc/localtime:/etc/localtime portainer/portainer --admin-password $(cat /root/portainer.admin.encrypted) 
    printf 'Portainer started. It can be reached through port 9000.'
fi
