#!/bin/bash
mkdir -p certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout certs/tls.key -out certs/tls.crt -subj "/C=BR/ST=Sao_Paulo/L=Sao_Paulo/O=My·Domination·Company/OU=IT·Department/CN=localhost"

echo
echo "Created tls.crt and tls.key"
echo
ls -l tls.*
echo



