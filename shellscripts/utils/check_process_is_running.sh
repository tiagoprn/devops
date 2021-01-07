#!/bin/bash

_isRunning() {
	## function to check if a process is alive and running:
	ps -o args= -C "$1" 2>/dev/null | grep -x "$1" >/dev/null 2>&1
	ps aux | grep "$1" 2>/dev/null | grep -v "grep" >/dev/null 2>&1
}

PROCESS_NAME=lxterm

## Verbose solution

if ! _isRunning $PROCESS_NAME; then
	echo "(verbose) $PROCESS_NAME NOT running!"
else
	echo "(verbose) $PROCESS_NAME Already running o/"
fi

## Shorter solution

_isRunning $PROCESS_NAME || echo "(shorter) $PROCESS_NAME NOT running!"

_isRunning $PROCESS_NAME && echo "(shorter) $PROCESS_NAME Already running o/"

