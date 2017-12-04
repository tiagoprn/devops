#!/bin/bash 

while (($(wc -l "netshoes.ee1be6ee26bb.20160706164137059551.scraped.csv" | awk '{print $1}') > 0)); do printf "Running\n"; sleep 2s; done    
