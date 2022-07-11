#!/bin/bash

# The repo of the rsync-time-backup script is at https://github.com/laurent22/rsync-time-backup.
# By default, the default --strategy is:
#	1:1 30:7 365:30 , which means:
#	  After 1 day, keep one backup every 1 day (1:1).
#	  After 30 days, keep one backup every 7 days (30:7).
#	  After 365 days, keep one backup every 30 days (365:30).

set -eou pipefail

DOWNLOAD_PATH="$HOME/.local/bin"
SCRIPT_FULL_PATH="$DOWNLOAD_PATH/rsync-time-backup.sh"

curl https://raw.githubusercontent.com/laurent22/rsync-time-backup/master/rsync_tmbackup.sh -o "$SCRIPT_FULL_PATH" && chmod 700 "$SCRIPT_FULL_PATH"
