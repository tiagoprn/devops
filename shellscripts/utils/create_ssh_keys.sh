#!/bin/bash

# Create directory if not exists, and set the right permissions
echo 'Creating directory...'
if [ ! -d ~/.ssh ]
then 
    mkdir ~/.ssh 
    chmod -R 700 ~/.ssh
    echo 'Directory created.'
else
    echo 'Directory already existed.'
fi

# Create ssh key if it not exists
echo 'Creating ssh key...'
if [ ! -f ~/.ssh/id_rsa ]
then 
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
    echo 'Key created.'
else
    echo 'Key already existed, it was not recreated.'
fi

echo 'Here is the public key:'

echo $(cat ~/.ssh/id_rsa.pub)


