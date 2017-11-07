## INTRODUCTION

This container can be used to provision CentOS 7 servers, installed from
the CentOS 7 Cloud Image, through ssh using ansible. This image assumes you 
have a centos user on this server (it is already on the cloud image) and you 
have your machine's ssh public key authorized to connect to it and run 
the playbook.  

## USING THE CONTAINER

To start the container: 

    $ make up

To enter the container to run ansible commands: 

    $ make bash

Now, we can start running ansible commands or playbooks. 

## RUNNING PLAYBOOKS

IMPORTANT: The `hosts` (remote machines) that ansible will connect to 
to run the playbooks are defined at `filesystem/conf/hosts` at this repository.  

First, let's test if the remote machines are responding: 

    $ ansible all -m ping   

The ping responding, now we should be able to run a playbook to provision the
machine: 

    $ cd /etc/ansible/playbooks/provision-centos7
    $ ansible-playbook -vv main.yml

To run just some tasks that were tagged on the playbook: 

    $ ansible-playbook --tags utilities,dotfiles -vv main.yml

(with `--skip-tags` you can do the opposite, and you can also use
`--start-at-task`)

To ignore "Host key mismatch for <ip>" here, configure this environment
variable (this is already set on the docker-compose file): 

    $ export ANSIBLE_HOST_KEY_CHECKING=False


## REFERENCE: 
https://serversforhackers.com/an-ansible-tutorial
    
