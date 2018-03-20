#!/bin/bash
# TODO: create a new certificate from existing private key
$ openssl req -new -key example.key -out example.csr -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
