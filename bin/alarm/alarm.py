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


def _get_current_timestamp():
    return datetime.now().strftime('%Y-%m-%d %H:%M')


def get_calendar_files():
    return [filename for filename in \
            glob.iglob(f'{CALENDARS_ROOT}/**/.calendar.txt',
                       recursive=True)]


def get_file_lines(file):
    file_context = file.split('/')[-2]
    logging.info(f'file_context={file_context}')
    with open(file, 'r') as input_file:
        return input_file.readlines()


def process_line(line):
    current_timestamp = _get_current_timestamp()
    current_time = current_timestamp.split()[1]
    logging.info(f'current_time={current_time}')
    logging.info(f'current_timestamp={current_timestamp}')

    line_elements = line.split()
    time_elements = []
    event_description_end_index = -1
    for index, element in enumerate(line_elements):
        if element.startswith('@'):
            if event_description_end_index == -1:
                event_description_end_index = index-1
            time_elements.append(element)
    len_time_elements = len(time_elements)
    if len_time_elements == 3:
        trigger_time = time_elements[0][1:]
        frequency = time_elements[1][1:]
        alarm_at = time_elements[2][1:]
        logging.info(f'trigger_time={trigger_time}, '
                        f'frequency={frequency}, '
                        f'alarm_at={alarm_at}')
        if frequency == 'daily' and trigger_time == current_time:
            import ipdb; ipdb.set_trace()
            logging.info('Calendar event ')


def process_file(file):
    for line in get_file_lines(file):
        process_line(line)


def process_files():
    files = get_calendar_files()
    for file in files:
        process_file(file)

if __name__ == "__main__":
    while True:
        sleep(60)
        process_files()

