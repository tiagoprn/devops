#!/bin/bash

# Replaces spaces and "." from a directory name to "_". 

# i is the name of the loop variable. 
# */ means every subdirectory of the current directory, and will include 
# a trailing slash in those names. Make sure you cd to the right place 
# before executing this. "$i" simply names that directory, including trailing 
# slash.  

for i in *; do
    extension=$(echo $i | awk -F . '{print $NF}') 
    newname=$(echo $i | sed "s/ /_/g" | sed "s/\.$extension//g" | grep -o -m 1 -P -e "_*[0-9]+$" | head -1 | sed 's/_//g' | xargs printf "%04.0f"); # -o is to just output the matched string, -m 1 is to stop at the first match, head -1 will ensure just the first match on the command output
    fullnewname="$newname.$extension"
    echo 'MOVING "'$i'" to "'$fullnewname'"...';
    mv "$i" "$fullnewname";
    rm -fr 0000.*;    
done
