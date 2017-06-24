#!/bin/bash
printf 'Generating portainer admin passwd...\n'
date | md5sum | awk '{print $1}' > /root/portainer.admin.passwd
printf 'Encrypting the generated admin passwd...\n'
docker run --rm httpd:2.4-alpine htpasswd -nbB admin $(cat /root/portainer.admin.passwd) | cut -d ":" -f 2 > /root/portainer.admin.encrypted
printf 'Done. The portainer admin passwd is at "/root/portainer.admin.passwd".\n'
printf 'Starting portainer in the background...\n'
docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer --admin-password $(cat /root/portainer.admin.encrypted) 
printf 'Portainer started. It can be reached through port 9000.'

