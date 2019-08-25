#!/usr/bin/env python3

import glob
import logging
import os
import sys
from datetime import datetime
from time import sleep


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

CALENDARS_ROOT = '/storage/docs/notes'


def get_calendar_files():
    return [filename for filename in \
            glob.iglob(f'{CALENDARS_ROOT}/**/.calendar.txt',
                       recursive=True)]


def get_calendar_records():
    current_timestamp = datetime.now().strftime('%Y-%m-%d %H:%M')
    current_minute = current_timestamp.split()[1]
    logging.info(f'current_minute={current_minute}')
    logging.info(f'current_timestamp={current_timestamp}')

    files = get_calendar_files()
    for file in files:
        file_context = file.split('/')[-2]
        logging.info(f'file_context={file_context}')
        with open(file, 'r') as input_file:
            lines = input_file.readlines()
        for line in lines:
            logging.info(line)


if __name__ == "__main__":
    while True:
        sleep(60)
        get_calendar_records()

