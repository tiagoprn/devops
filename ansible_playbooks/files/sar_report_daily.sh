#!/bin/bash
DATE=$(date +%d)
FULLDATE=$(date +%Y%m%d)
mkdir -p /var/log/sysstat/reports
sadf -T -jh /var/log/sa/sa$DATE -- | sed 's/;/,/g' > /var/log/sysstat/reports/system_stats_$FULLDATE.json
