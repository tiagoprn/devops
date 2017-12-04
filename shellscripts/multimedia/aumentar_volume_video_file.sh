#!/bin/bash

# where volume 256 = 100%; volume 512 = 200% ; etc...

ffmpeg -i input.flv -vol 512 -vcodec copy output.flv
