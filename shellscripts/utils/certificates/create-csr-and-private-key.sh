#!/bin/bash

# Field Meaning              Example
# /C=   Country              GB
# /ST=  State                London
# /L=   Location             London
# /O=   Organization         Global Security
# /OU=  Organizational Unit  IT Department
# /CN=  Common Name          example.com

SYNTAX="./create-csr-and-private-key.sh -o [OUTPUT_DIR]"
HELP="./create-csr-and-private-key.sh -o /certificates/webserver"

while getopts o: option
do
  case "${option}"
  in
  o) OUTPUT_DIR=${OPTARG};;
  esac
done

echo 'Parsing script parameters...'
if [[ -z $OUTPUT_DIR ]]; then
    printf "Missing -o parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi

mkdir -p $OUTPUT_DIR

echo 'Generating the certificate and the private key separately...'
openssl req -nodes -newkey rsa:4096 -keyout $OUTPUT_DIR/private.key -out $OUTPUT_DIR/certificate.csr -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My Domination Company/OU=IT Department/CN=localhost"

echo 'Generating concatenated certificate, with the private_key bundled...' 
cat $OUTPUT_DIR/certificate.csr $OUTPUT_DIR/private.key > $OUTPUT_DIR/certificate.full.pem

echo "DONE. The certificate and private key are at $OUTPUT_DIR. You may use individually the CSR and KEY files, or for your convenience the PEM file which contains both files."
