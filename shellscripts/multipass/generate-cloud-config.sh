#!/bin/bash

# reference: https://gist.github.com/bloodearnest/ebf044476e70c4baee59c5000a10f4c8

set -eu

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

# configure profile
# this will rewrite the whole profile
cat << EOF | cat > cloud-config.yaml
#cloud-config

# Users
users:
    - name: ubuntu
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

bootcmd:
    - echo '>>>>>> Starting cloud-init... <<<<<<'

# Remove cloud-init when finished with it
runcmd:
    - [ dpkg, -y, remove, cloud-init ]

# Configure where output will go
output:
    all: ">> /var/log/cloud-init.log"

# configure interaction with ssh server
ssh_genkeytypes: ['ed25519', 'rsa']

# Install my public ssh key to the first user-defined user configured
# in cloud.cfg in the template (which is ubuntu for ubuntu cloud images)
ssh_authorized_keys:
    - ${KEY}

timezone: ${TIMEZONE}
EOF

