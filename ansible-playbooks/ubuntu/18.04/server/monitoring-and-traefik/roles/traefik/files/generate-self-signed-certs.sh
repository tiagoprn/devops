#!/bin/bash
CERTS_DIR=/opt/containers/traefik/certs
CERTIFICATE_FILE=$CERTS_DIR/tls.crt
KEY_FILE=$CERTS_DIR/tls.key

echo "Creating certificates directory $CERTS_DIR..." && \
mkdir -p $CERTS_DIR &&\
echo "Issuing certificate..."&& \
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY_FILE -out $CERTIFICATE_FILE -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My·Domination·Company/OU=IT·Department/CN=localhost" &&\
echo "Certificate created at $CERTS_DIR." &&\
ls -l $CERTS_DIR/tls* &&\
echo "FINISHED."

