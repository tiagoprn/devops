#!/bin/bash
# Cleans the machine cache memory, kinda like reboot the OS clean.
sync; 
echo 3 > /proc/sys/vm/drop_caches;
