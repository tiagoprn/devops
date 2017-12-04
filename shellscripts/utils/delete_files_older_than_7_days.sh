#!/bin/bash
log="old_files_deleted.txt"
find /mnt/EXT1ST/BACKUPS/digitalocean_tanostools -name "*.tar.bz2" -mtime +7 | while read fname; do
    rm -fr $fname;
    echo "on: $(date +%Y%m%d_%H%M%S), deleted: $fname" >> $log
done
