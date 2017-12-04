#!/bin/bash

for i in *.flv; do
ffmpeg -i $i -ar 44100 -ab 160000 -ac 2 $i.mp3
done


 
