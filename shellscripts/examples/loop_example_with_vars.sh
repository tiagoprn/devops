#!/bin/bash

SPIDERS="colombo kd_pneus gbg_pneus itaro hipervarejo della_via autoz pneumar pneustore pneusola" 

for spider in $SPIDERS; do 
    nohup scrapy crawl $spider -s CONCURRENT_REQUESTS=24 -s CONCURRENT_REQUESTS_PER_DOMAIN=24 -s CONCURRENT_REQUESTS_PER_IP=24 -o scraped/$spider.csv > logs/$spider.log
done

