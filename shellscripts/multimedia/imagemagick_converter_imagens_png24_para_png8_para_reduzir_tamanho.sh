#!/bin/bash
for foto in *.png; do 
    convert "$foto" -depth 4 "$foto"
done
