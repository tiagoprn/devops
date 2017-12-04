#!/bin/bash 

log="/tmp/files_processed.txt"
find /home/tiago/precifica/tmp/SCRAPY_2016_JUNHO/ -name "*.scraped.csv" | while read fname; do
    ls -lha $fname;
    echo "on: $(date +%Y%m%d_%H%M%S), processed: $fname" >> $log
done
