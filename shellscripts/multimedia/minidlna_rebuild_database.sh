#!/bin/bash
sudo systemctl stop minidlna
sudo minidlnad -f /etc/minidlna.conf -R
sudo systemctl start minidlna
sudo systemctl status minidlna
