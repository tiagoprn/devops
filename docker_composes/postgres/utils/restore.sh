#!/bin/bash

##### FULL DATABASE #####
pg_restore --host localhost --port 5432 --username "tmc" --dbname "tmc_financeiro" --clean --role "tmc" -W --jobs 1 --verbose /utils/postgres/tmc_financeiro.c.backup
