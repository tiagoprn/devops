#!/bin/bash

# reference: https://gist.github.com/bloodearnest/ebf044476e70c4baee59c5000a10f4c8

# To launch a container using this profile:
#   $ lxc launch ubuntu: -p default -p $PROFILE_NAME

set -eu

PROFILE_NAME="centos.cloud-init.config"

PUBKEY=${HOME}/.ssh/id_rsa.pub
if [ ! -f "${PUBKEY}" ]
then
    # Check for existence of a pubkey, or else exit with message
    echo "[$(date +%r)]----> [ERROR] Please generate an SSH keypair using 'ssh-keygen -t rsa'. This key will be authorized to login as the CentOS 7 centos cloud image user."
    exit 3
else
    # Place contents of $PUBKEY into $KEY
    KEY=$(<${PUBKEY})
fi

SUDOGROUP="wheel"
TIMEZONE=America/Sao_Paulo

# create a profile to control this, name it after $USER
lxc profile create $PROFILE_NAME &> /dev/null || true

# configure profile
# this will rewrite the whole profile
cat << EOF | lxc profile edit $PROFILE_NAME
name: $PROFILE_NAME
description: setup cloud-init for a centos 7 container
config:
  # note: user.user-data is still available
  user.vendor-data: |
    #cloud-config

    # Users
    users:
        - name: centos
          groups: ['${SUDOGROUP}']
          shell: /bin/bash
          sudo: ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            - ${KEY}
        - name: ops
          groups: ['${SUDOGROUP}']
          shell: /bin/bash
          sudo: ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            - ${KEY}

    # Remove cloud-init when finished with it
    runcmd:
        - [ yum, -y, remove, cloud-init ]

    # Configure where output will go
    output:
        all: ">> /var/log/cloud-init.log"

    # configure interaction with ssh server
    ssh_genkeytypes: ['ed25519', 'rsa']

    # Install my public ssh key to the first user-defined user configured
    # in cloud.cfg in the template (which is centos for CentOS cloud images)
    ssh_authorized_keys:
        - ${KEY}

    timezone: ${TIMEZONE}
EOF

