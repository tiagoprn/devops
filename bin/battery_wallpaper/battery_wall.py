#!/usr/bin/env python3

# ANSI escape codes (for color support:
# http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html)

from os import getenv, path
from pathlib import Path
from subprocess import check_output, run
from sys import stdout

# Colors
RED='\033[1;31m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
RESET='\033[0m'

stdout.write(f"{YELLOW} Executing... {RESET}\n")

# outpath = Path.cwd() / 'output' / 'output.xlsx'

DIR = Path.cwd()

# command=f"{SUDO} ls {DES} && echo 'DONE'"
# run(command, shell=True)

command = 'ls /sys/class/power_supply/ | grep -i BAT | head -n 1'
result = check_output(command, shell=True)
output = result.decode()

stdout.write(f'BAT={output}')

stdout.write(f"{GREEN} Finished. {RESET}\n")
