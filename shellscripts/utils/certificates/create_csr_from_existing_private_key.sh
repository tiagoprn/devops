#!/bin/bash

# Field Meaning              Example
# /C=   Country              GB
# /ST=  State                London
# /L=   Location             London
# /O=   Organization         Global Security
# /OU=  Organizational Unit  IT Department
# /CN=  Common Name          example.com

openssl req -new -key private.key -out 2nd_certificate.csr -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My Domination Company/OU=IT Department/CN=localhost"
cat 2nd_certificate.csr private.key > 2nd_certificate.with_private_key.pem
