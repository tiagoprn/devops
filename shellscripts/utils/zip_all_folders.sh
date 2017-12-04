#!/bin/bash

# i is the name of the loop variable. 
# */ means every subdirectory of the current directory, and will include 
# a trailing slash in those names. Make sure you cd to the right place 
# before executing this. "$i" simply names that directory, including trailing 
# slash. The quotation marks ensure that whitespace in the directory name 
# won't cause trouble. ${i%/} is like $i but with the trailing slash removed, 
# so you can use that to construct the name of the zip file.

# If you want to see how this works, include an echo before the 
# zip and you will see the commands printed instead of executed.

for i in */; do 
    zip -r "${i%/}.zip" "$i"; 
done
