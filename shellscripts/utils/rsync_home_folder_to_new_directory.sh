#!/bin/bash

printf 'IMPORTANT: This script is intended to be run with root permisions.\n'

DESTINATIONFOLDER=/vault/home_new
LOGFILE=/vault/rsync_progress.log
chmod --reference=/home $DESTINATIONFOLDER
chown --reference=/home $DESTINATIONFOLDER

rsync -aczPviXS --log-file=$LOGFILE /home/* $DESTINATIONFOLDER/
# -a: archive mode; equals -rlptgoD (this will keep owner, group).  
# -c: skip based on checksum, not mod-time & size   
# -z: compress file data during the transfer (useful over a network)
# -P: keep partial files (allow resuming from where it stopped if ever interrupted), and also shows progress.
# -v: verbose mode 
# -i: output a change-summary for all updates
# -X: preserve extended attributes
# -S: handle sparse files efficiently; allocate dest files before writing

# -n: dry-run: this will just result on a "trial run", with no changes really applied to the filesystem.

# NOTE: For other origin directories, maybe adding "-H" (preserve hard links), may be a good
# choice to make a full carbon copy of a directory. Just take into account this
# operation is expensive. But you must search online if this will suffice. 
# This script just take into consideration a common "/home", with no hard
# links. 

printf 'After finishing: \n\n'
printf '        umount DESTINATIONFOLDER \n'
printf 'Edit /etc/fstab, changing "DESTINATIONFOLDER" to "/home". \n'
printf 'Backup the old /home: \n '
printf '        mv /home /home.OLD \n'
printf 'Remount the filesystems: \n'
printf '        mount -a \n'
