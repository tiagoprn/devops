#!/bin/bash

# Take one argument from the commandline: VM name
if ! [ $# -eq 1 ]; then
    echo "Usage: $0 <vm-name>"
    exit 1
fi

PUBKEY=${HOME}/.ssh/id_rsa.pub
if [ ! -f "${PUBKEY}" ]
then
    # Check for existence of a pubkey, or else exit with message
    echo "[$(date +%r)]----> [ERROR] Please generate an SSH keypair using 'ssh-keygen -t rsa'. This key will be authorized to login as the cloud image user."
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
fqdn: $1.kvm.local

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


bootcmd:
  - echo 'My ip addresses are '$(hostname --ip-address)

# Remove cloud-init when finished with it
runcmd:
  - [ yum, -y, remove, cloud-init ]

# Configure where output will go
output:
  all: ">> /var/log/cloud-init.log"

# configure interaction with ssh server
ssh_genkeytypes: ['ed25519', 'rsa']

# Install my public ssh key to the user configured
# in cloud.cfg in the template
ssh_authorized_keys:
  - ${KEY}

# phone_home:
#  url: http://my.example.com/$INSTANCE_ID/
#  post: [ pub_key_dsa, pub_key_rsa, pub_key_ecdsa, instance_id ]

timezone: ${TIMEZONE}
_EOF_

echo "instance-id: $1; local-hostname: $1" > $META_DATA

# Create CD-ROM ISO with cloud-init config
echo "$(date -R) Generating ISO for cloud-init..."
genisoimage -output $CI_ISO -volid cidata -joliet -r $USER_DATA $META_DATA &>> $1.log
mv *.iso $HOME/distros/images
rm meta-data *.log user-data
