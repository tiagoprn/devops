#!/bin/bash
for file in *;
  do mv "$file" `echo $file | sed -e 's/  */_/g' -e 's/_-_/-/g'`;
done