DIRECTORIES="$HOME/.ssh $HOME/.local $HOME/.config $HOME/.gnupg $HOME/.mozilla $HOME/.bash_history $HOME/.mycli-history $HOME/.NERDTreeBookmarks $HOME/.s3cfg $HOME/.PyCharm*"

DESTINATION="/storage/backups/"
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"

mkdir -p $DESTINATION/$TIMESTAMP

for directory in $DIRECTORIES; do 
   echo '>>>' Backing up $directory '...';
   BACKUP_FILE_NAME=$(hostname).`echo $directory | sed "s/\//\-/g"`
   tar cfjv $DESTINATION/$TIMESTAMP/$BACKUP_FILE_NAME.tar.bz2 $directory
   echo '-------------------------------------';
done

FILENAME=$DESTINATION/$(hostname).home_folder.$TIMESTAMP.tar

tar cfv $FILENAME $DESTINATION/$TIMESTAMP
rm -fr $DESTINATION/$TIMESTAMP

echo "Finished backup of $(hostname) at $FILENAME."
