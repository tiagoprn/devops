#!/bin/bash
echo 'Your user must have permissions to run YUM and SYSTEMD.'
echo 'Installing monitorix dependencies...';
yum install rrdtool rrdtool-perl perl-libwww-perl perl-MailTools perl-MIME-Lite perl-CGI perl-DBI perl-XML-Simple perl-Config-General perl-HTTP-Server-Simple perl-IO-Socket-SSL;
echo 'Installing monitorix...';
rpm -ivh http://www.monitorix.org/monitorix-3.6.0-1.noarch.rpm;
echo 'Starting monitorix...';
systemctl start monitorix;
echo 'Enable monitorix as a service at boot time...'
systemctl enable monitorix;
echo 'DONE.'
