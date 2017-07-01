## INTRODUCTION

This container can be used to provision CentOS 7 servers, installed from
the minimal installation, through ssh using ansible. I assume you have a root
user on this server and you know its password to connect to it and run the
playbook.  

## USING THE CONTAINER

To start the container: 

    $ make up

Then, create the ssh keys, that will be generated to allow the ansible host to
directly connect to its slaves: 
    
    $ make generate-keys

To enter the container to run ansible commands: 

    $ make bash

Now, we can start running ansible commands or playbooks. 

## RUNNING PLAYBOOKS

IMPORTANT: The `hosts` (remote machines) that ansible will connect to 
to run the playbooks are defined at `filesystem/conf/hosts` at this repository.  

First, let's test if the remote machines are responding: 

    $ ansible all -m ping -k   

IMPORTANT:
`-k` here means we want to type the password of the root user of the CentOS 7 
machine instead of using ssh keys to connect to it. Once you have the host ssh
keys to connect to the hosts, it can be safely ommited.

The ping responding, now we should be able to run a playbook to provision the
machine: 

    $ cd /etc/ansible/playbooks
    $ ansible-playbook -vv -k -s provision_centos7.yml 

To ignore "Host key mismatch for <ip>" here, configure this environment
variable (this is already set on the docker-compose file): 

    $ export ANSIBLE_HOST_KEY_CHECKING=False


## REFERENCE: 
https://serversforhackers.com/an-ansible-tutorial
    
