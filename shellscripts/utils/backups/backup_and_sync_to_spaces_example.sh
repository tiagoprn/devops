#!/bin/bash
# The awk command below will prepend the current time to each line of the log
# file. 

mkdir -p ~/logs
cd /storage/docs && rclone sync -vv . spaces:tiagoprn/destination1 | awk '{ print strftime("%D %T: "), $0; fflush(); }' >> ~/logs/backup.log 2>&1
./backup_shellscripts.sh | awk '{ print strftime("%D %T: "), $0; fflush(); }' >> ~/logs/backup.log 2>&1
cd /storage/backups && rclone sync -vv . spaces:tiagoprn/destination2 | awk '{ print strftime("%D %T: "), $0; fflush(); }' >> ~/logs/backup.log 2>&1

