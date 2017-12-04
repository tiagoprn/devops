#!/bin/bash
DIRECTORIES="bin .cache .ccache .config Documentos Downloads .dropbox .dropbox-dist Dropbox .gitconfig .gnupg Imagens keys .links .local .mozilla .parallel .pip .Skype .ssh .subversion .thumbnails tmp vault /vault .bash*"
for directory in $DIRECTORIES; do 
   echo '>>>' $directory ':';
   ls -la $directory; 
   echo '-------------------------------------';
done

