#!/bin/bash

# Take one argument from the commandline: VM name
if ! [ $# -eq 1 ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

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

USER_DATA=user-data
META_DATA=meta-data
CI_ISO=$1-cloud-init-data.iso

# cloud-init config: set hostname, remove cloud-init package,
# and add ssh-key
cat > $USER_DATA << _EOF_
#cloud-config

# Hostname management
preserve_hostname: False
hostname: $1
fqdn: $1.vbox.local

# Users
users:
    - name: ubuntu
      groups: ['${SUDOGROUP}']
      shell: /bin/bash
      sudo: ALL=(ALL) NOPASSWD:ALL
      ssh_authorized_keys:
        - ${KEY}

bootcmd:
  - echo 'My ip addresses are '$(hostname --ip-address)

# Remove cloud-init when finished with it
runcmd:
  - [ apt, remove, cloud-init, -y ]

# Configure where output will go
output:
  all: ">> /var/log/cloud-init.log"

# configure interaction with ssh server
ssh_genkeytypes: ['ed25519', 'rsa']

# Install my public ssh key to the first user-defined user configured
# in cloud.cfg in the template (which is centos for CentOS cloud images)
ssh_authorized_keys:
  - ${KEY}

# phone_home:
#  url: http://my.example.com/$INSTANCE_ID/
#  post: [ pub_key_dsa, pub_key_rsa, pub_key_ecdsa, instance_id ]

timezone: ${TIMEZONE}
_EOF_


mv user-data cloud_init.cfg

