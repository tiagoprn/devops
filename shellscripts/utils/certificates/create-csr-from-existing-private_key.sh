#!/bin/bash

# Field Meaning              Example
# /C=   Country              GB
# /ST=  State                London
# /L=   Location             London
# /O=   Organization         Global Security
# /OU=  Organizational Unit  IT Department
# /CN=  Common Name          example.com

SYNTAX="./create-csr-from-existing-private-key.sh -p [OUTPUT_DIR]"
HELP="./create-csr-from-existing-private-key.sh -p /certificates/webserver/private.key"

while getopts p: option
do
  case "${option}"
  in
  p) PRIVATE_KEY_FULL_PATH=${OPTARG};;
  esac
done

echo 'Parsing script parameters...'
if [[ -z $PRIVATE_KEY_FULL_PATH ]]; then
    printf "Missing -p parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi

OUTPUT_DIR=$(dirname $PRIVATE_KEY_FULL_PATH)

echo 'Generating a new certificate signing request (csr) from the existing private key...'
openssl req -new -key $PRIVATE_KEY_FULL_PATH -out $OUTPUT_DIR/2nd_certificate.csr -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My Domination Company/OU=IT Department/CN=localhost"

echo 'Generating the self-signed certificate...'
openssl x509 -req -sha256 -days 365 -in $OUTPUT_DIR/2nd_certificate.csr -signkey $PRIVATE_KEY_FULL_PATH -out $OUTPUT_DIR/2nd_certificate.crt

echo 'Generating concatenated certificate, with the private_key bundled...' 
cat $PRIVATE_KEY_FULL_PATH $OUTPUT_DIR/2nd_certificate.crt > $OUTPUT_DIR/2nd_certificate.full.pem

echo "DONE. The certificate and private key are at $OUTPUT_DIR. You may use individually the CRT and KEY files, or for your convenience the PEM file which contains both files."
