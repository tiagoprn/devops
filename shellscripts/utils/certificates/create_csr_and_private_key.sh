#!/bin/bash

# Field Meaning              Example
# /C=   Country              GB
# /ST=  State                London
# /L=   Location             London
# /O=   Organization         Global Security
# /OU=  Organizational Unit  IT Department
# /CN=  Common Name          example.com

openssl req -nodes -newkey rsa:4096 -keyout private.key -out certificate.csr -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My Domination Company/OU=IT Department/CN=localhost"
cat certificate.csr private.key > certificate.with_private_key.pem
