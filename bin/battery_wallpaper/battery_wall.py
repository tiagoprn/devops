#!/usr/bin/env python3

# ANSI escape codes (for color support:
# http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html)

import logging

from os import getenv, path
from pathlib import Path
from subprocess import check_output, run
from sys import stdout

# Logging configuration

LOG_VARS='levelname asctime msecs name funcName lineno processName process message'
LOG_FORMAT = ''
for index, variable in enumerate(LOG_VARS.split()):
    if variable != 'message':
        if index > 0:
            LOG_FORMAT += ':'
        LOG_FORMAT += f'%({variable})s'
    else:
        LOG_FORMAT += f' :: %({variable})s'

logging.basicConfig(format=LOG_FORMAT, stream=stdout, level=logging.DEBUG)

# Terminal Colors
RED='\033[1;31m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
RESET='\033[0m'

def run_and_get_stdout(command: str) -> list:
    result = check_output(command, shell=True)
    return result.decode().split('\n')

if __name__ == '__main__':
    stdout.write(f"{YELLOW} Executing... {RESET}\n")

    # outpath = Path.cwd() / 'output' / 'output.xlsx'

    DIR = Path.cwd()

    # command=f"{SUDO} ls {DES} && echo 'DONE'"
    # run(command, shell=True)

    command = 'ls /sys/class/power_supply/ | grep -i BAT | head -n 1'
    logging.info(f'Running command >>> {command}...')
    BAT = run_and_get_stdout(command)[0]
    stdout.write(f'BAT={BAT}\n')

    command=f"cat /sys/class/power_supply/{BAT}/capacity"
    logging.info(f'Running command >>> {command}...')
    BATTERY = run_and_get_stdout(command)[0]
    stdout.write(f'BATTERY={BATTERY}\n')

    command="ls /sys/class/power_supply/ | grep -i AC | head -n 1"
    logging.info(f'Running command >>> {command}...')
    AC = run_and_get_stdout(command)[0]
    stdout.write(f'AC={AC}\n')

    command=f"cat /sys/class/power_supply/{AC}/online"
    logging.info(f'Running command >>> {command}...')
    CHARGE = run_and_get_stdout(command)[0]
    stdout.write(f'CHARGE={CHARGE}\n')

    stdout.write(f"{GREEN} Finished. {RESET}\n")
