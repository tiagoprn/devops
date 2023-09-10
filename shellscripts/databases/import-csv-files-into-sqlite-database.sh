#!/usr/bin/env bash

ROOT_PATH="."

DATABASE_FILE_NAME="imported_csvs.$(date +%Y%m%d-%H%M%S-%N).db"

FILES_PATH="$ROOT_PATH/*.csv"
for FILE in $FILES_PATH; do
    # echo "Full file path: $FILE"
    filename=$(basename -- "$FILE")
    table_name=$(echo "$filename" | cut -d '.' -f 1)
    csvsql --db sqlite:///$DATABASE_FILE_NAME --insert --tables "$table_name" $FILE
    echo "Finished importing file '$filename' into table '$table_name'"
done
