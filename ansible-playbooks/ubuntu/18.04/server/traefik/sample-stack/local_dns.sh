#!/bin/bash
echo "# The following lines are desired so that you can host apps on your machine (e.g., traefik)" >> /etc/hosts
echo "127.0.0.1 www.example.com example.com nginx.example.com traefik.example.com tomcat.example.com mysql.example.com" >> /etc/hosts
echo "1.1.1.1 www.example.com example.com nginx.example.com traefik.example.com tomcat.example.com mysql.example.com"  >> /etc/hosts

