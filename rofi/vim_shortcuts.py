#!/usr/bin/env python3

import glob
import logging
import os
import sys

from rofi import Rofi

CURRENT_SCRIPT_NAME = os.path.splitext(os.path.basename(__file__))[0]
LOG_FORMAT = ('[%(asctime)s PID %(process)s '
              '%(filename)s:%(lineno)s - %(funcName)s()] '
              '%(levelname)s -> \n'
              '%(message)s\n')
# Configure the logging to console. Works from python 3.3+
logging.basicConfig(
    format=LOG_FORMAT,
    level=logging.INFO,
    handlers=[logging.StreamHandler(sys.stdout)]
)

def get_shortcuts():
    shortcuts_list = []
    filename = '/storage/src/dot_files/.vimrc'
    with open(filename, 'r') as input_file:
        lines = input_file.readlines()
    for line in lines:
        if line.replace('\n', '') and ('| "' in line):
            shortcut, description = line.split('| "')
            if shortcut and description:
                _shortcut = shortcut[1:].strip() if shortcut.startswith('"') else shortcut.strip()
                shortcuts_list.append(f'{description.strip()} => {_shortcut}')
    return sorted(shortcuts_list)


if __name__ == "__main__":
    shortcuts_list= get_shortcuts()

    rofi_client = Rofi()
    selected, keyboard_key = rofi_client.select(
        'Filter a vim shortcut',
        shortcuts_list,
        fullscreen=True,
        other_args=['--no-case-sensitive'])
    logging.info(f'keyboard_key pressed={keyboard_key}')

    if keyboard_key == -1:
        logging.info('cancelled')
        sys.exit(0)

