#!/bin/bash
TARGET="$1"
me=`basename "$0"`
#--output-format=json
fio --loops=1 --size=1024m --filename="$TARGET/fiomark.tmp" --stonewall --ioengine=libaio --direct=1 --zero_buffers=0 \
--name="$me" --bs=1m --iodepth=8 --numjobs=1 --rw=read --output-format=json

rm "$TARGET/fiomark.tmp"