## INTRODUCTION

This container can be used to provision CentOS 7 servers, installed from
the minimal installation, through ssh using ansible. I assume you have a root
user on this server and you know its password to connect to it and run the
playbook.  

## USING THE CONTAINER

To start the container: 

    $ make up

To enter the container to run ansible commands: 

    $ make bash

Now, we can start running ansible commands or playbooks. 

## RUNNING PLAYBOOKS

First, let's test if the remote machines are responding: 

    $ ansible all -m ping -k   

IMPORTANT:
`-k` here means we want to type the password of the root user of the CentOS 7 
machine instead of using ssh keys to connect to it.

The ping responding, now we should be able to run a playbook to provision the
machine: 

    $ cd /etc/ansible/playbooks
    $ ansible-playbook -k -s provision.yml 

## REFERENCE: 
https://serversforhackers.com/an-ansible-tutorial
    
