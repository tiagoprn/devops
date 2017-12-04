#!/bin/bash

# Replaces digits and "-" from a directory name. 
# E.g.: 
# "walmart-1456614965" will become "walmart".

# i is the name of the loop variable. 
# */ means every subdirectory of the current directory, and will include 
# a trailing slash in those names. Make sure you cd to the right place 
# before executing this. "$i" simply names that directory, including trailing 
# slash.  

for i in */; do 
    newname=$(echo $i | sed 's/[0-9]//g' | sed 's/\-//g');
    echo $newname;
    echo $i;
    echo 'MOVING "'$i'" to "'$newname'"...';
    mv $i $newname;    
done
