DIRECTORIES="$HOME/.ssh $HOME/.config $HOME/.local $HOME/.gnupg /storage/work"

DESTINATION="/storage/BACKUPS/"
TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"

mkdir -p $DESTINATION/$TIMESTAMP

for directory in $DIRECTORIES; do 
   echo '>>>' Backing up $directory '...';
   BACKUP_FILE_NAME=$(hostname).`echo $directory | sed "s/\//\-/g"`
   tar cfjv $DESTINATION/$TIMESTAMP/$BACKUP_FILE_NAME.tar.bz2 $directory
   echo '-------------------------------------';
done

echo "Finished backup of $(hostname)."
