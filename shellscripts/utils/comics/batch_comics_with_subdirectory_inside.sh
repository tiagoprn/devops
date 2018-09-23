#!/bin/bash

COMIC_NAME=$(basename "$PWD")
COMIC_PATH=$(echo $PWD | sed "s/$COMIC_NAME$//g")
find . -mindepth 1 -type d | sort |
while read dir; do
    find "$dir" -mindepth 1 -maxdepth 1 -type f -print | sort | 
    while read file; do
        NEW_NAME=$(echo $file | sed 's/^\.\///g' | sed 's/\//_/g')
        echo "$file will be copied to $COMIC_PATH$COMIC_NAME/$NEW_NAME"
        cp -farv $file $COMIC_PATH$COMIC_NAME/$NEW_NAME
    done
    rm -fr "$dir" 
done
find . -name '*' -print | sort | zip -j $COMIC_NAME.cbz -@

