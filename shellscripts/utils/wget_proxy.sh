#!/bin/bash

export http_proxy="127.0.0.1:8118";
export ftp_proxy="127.0.0.1:8118";

echo '';

echo 'http proxy: ';
echo $http_proxy;

echo '';

echo 'ftp_proxy: ';
echo $ftp_proxy;

echo '';

echo 'PRONTO! Agora rode o wget normalmente.'
