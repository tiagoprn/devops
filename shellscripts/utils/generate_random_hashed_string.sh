#!/bin/bash

# To list other hash algorithms supported by openssl:
#   $ openssl list -digest-algorithms
HASH_ALGORITHM=ssl3-sha1

bash ./random_password.sh | openssl dgst -$HASH_ALGORITHM | awk '{print $2}'

