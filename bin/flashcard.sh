#!/usr/bin/env bash

_isRunning() {
	## function to check if a process is alive and running:
	ps -o args= -C "$1" 2>/dev/null | grep -x "$1" >/dev/null 2>&1
	ps aux | grep "$1" 2>/dev/null | grep -v "grep" >/dev/null 2>&1
}

_isRunning urxvt || urxvt --hold --title flashcard -e /bin/bash -c 'fortune -u -e -c /storage/src/fortunes/ | tail +3 | cowsay -b -f dragon -W 80' &
