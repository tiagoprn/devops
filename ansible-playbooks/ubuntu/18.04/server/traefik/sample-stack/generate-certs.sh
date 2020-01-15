#!/bin/bash
wget https://raw.githubusercontent.com/tiagoprn/devops/master/shellscripts/utils/certificates/create-csr-and-private-key.sh
chmod 700 create-csr-and-private-key.sh
mkdir -p certs
./create-csr-and-private-key.sh -o certs/

