#!/bin/bash

# Replaces spaces and "." from a directory name to "_". 

# i is the name of the loop variable. 
# */ means every subdirectory of the current directory, and will include 
# a trailing slash in those names. Make sure you cd to the right place 
# before executing this. "$i" simply names that directory, including trailing 
# slash.  

for i in */; do 
    # newname=$(echo $i | sed 's/[0-9]//g' | sed 's/\-//g');
    newname=$(echo $i | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/SS_Lost_Canvas_//g');
    echo 'MOVING "'$i'" to "'$newname'"...';
    mv "$i" "$newname";    
done
