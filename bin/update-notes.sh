#!/bin/bash

cd /storage/docs/notes && \
echo -e "\n\n\n"
echo -e "********************************************************************************************" && \
echo -e "$(date +%Y%m%d-%H%M%S): Commiting and pushing to notes repo..." && \
git add . && \
git commit -m "automated commit on $(hostname) at $(date '+%A %d, %B %Y %H:%M:%S')" > /dev/null && \
git push origin master > /dev/null 2>&1 && \
echo -e "----------" && \
git glog -n 3 && \
echo -e "----------" && \
git files-changed -n 1 && \
echo -e "----------" && \
echo -e "SUCCESSFULLY FINISHED! o/\n"
echo -e "Press <ENTER> to close this window and go back to vim."
read KEY
