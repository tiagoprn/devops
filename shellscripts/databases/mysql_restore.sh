#!/bin/bash
# reload database, renaming it from "mydb" to "mydb_devel"
mysql -u myuser -pPASSWORD -A -Dmydb_devel < dump.sql
