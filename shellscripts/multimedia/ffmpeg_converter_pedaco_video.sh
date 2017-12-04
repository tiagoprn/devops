#!/bin/bash

#-ss 00:00:00 -t 00:5:00 #converte 5 minutos, a partir do início do filme (00:00:00)
ffmpeg -i 102.mkv -target ntsc-dvd -aspect 16:9 -ss 00:00:00 -t 00:5:00 102.avi
