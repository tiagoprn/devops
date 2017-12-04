#!/bin/bash
#Montar os diretorios public_html e public_python:
mount --bind /media/container/git_tiagoprnl.servidorgh.info/repositorios/django_projects /home/tiago/public_python &
mount --bind /media/container/git_tiagoprnl.servidorgh.info/repositorios/public_html /home/tiago/public_html &
mount --bind /media/container/git_tiagoprnl.servidorgh.info/repositorios/django_projects_media /var/www/html/media &
