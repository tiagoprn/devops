#!/bin/bash
DATE=$(date +%d)
FULLDATE=$(date +%Y%m%d)
REPORTS_DIR=/var/log/sysstat/sysstat_daily_reports
mkdir -p $REPORTS_DIR
sadf -T -jh /var/log/sysstat/sa$DATE -- -n DEV -q -d -r -u | sed 's/;/,/g' > $REPORTS_DIR/system_stats_$FULLDATE.json
