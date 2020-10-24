#!/bin/bash
apt-get install rrdtool perl libwww-perl libmailtools-perl libmime-lite-perl librrds-perl libdbi-perl libxml-simple-perl libhttp-server-simple-perl libconfig-general-perl libio-socket-ssl-perl
wget -c -t inf -T 40 http://www.monitorix.org/monitorix_3.6.0-izzy1_all.deb
dpkg -i monitorix_3.6.0-izzy1_all.deb
apt-get -f install 
service monitorix enable
service monitorix restart
