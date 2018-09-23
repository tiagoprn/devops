#!/bin/bash

for i in */; do
    rm .cbz; 
    filename=$(echo $i |sed 's/\///g') 
    find $i/ -name '*' -print | sort | zip -j $filename.cbz -@
    echo 'GENERATED "'$filename'.cbz" !';
done
