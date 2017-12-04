#!/bin/bash
OUTPUT_FILE=mysql_mydb.DEVELOPMENT.$(date +%Y%m%d_%H%M%S).sql
mysqldump -u myuser -pPASSWORD --add-drop-table mydb_devel --result-file=$OUTPUT_FILE
