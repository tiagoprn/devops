#!/usr/bin/env python3

"""
This script has 2 modes of execution: daemon and client.

The daemon runs on background (recommended when the window manager starts).
It watches the system clipboard, and when a new one arrives it writes it
to a file.

The client reads the file written by the daemon and opens a rofi dialog to
select a past clipboard entry from that file, so that you can put it back on
your clipboard.

To start as a daemon:
  python3 clippy.py

To start as the client:
  python3 clippy.py --no-daemon-mode

The idea is to be KISS - no fancy or bloat here.

## Ubuntu packages that must be installed to run successfully:

    $ sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 -y

## 3rd party pypi libraries required to run successfully:
- daemonize: to abstract the daemon
- pyperclip: to abstract the clipboard
- typer: to easily parse the cli arguments
To install the libraries globally on your distro, run:
$ sudo pip3 install daemonize pyperclip typer

"""

import json
import logging
import os
import sys
from datetime import datetime
from functools import partial
from subprocess import run
from time import sleep

import gi
import pyperclip
import typer
from daemonize import Daemonize
from gi.repository import Gdk, Gtk
from rofi import Rofi

gi.require_version('Gtk', '3.0')


CURRENT_SCRIPT_NAME = os.path.splitext(os.path.basename(__file__))[0]
LOG_FILE = f'/tmp/{CURRENT_SCRIPT_NAME}.log'
PIDFILE = f'/tmp/{CURRENT_SCRIPT_NAME}.pid'
CLIPBOARD_HISTORY_FILE = f"{os.environ['HOME']}/clipboard.history"

LOG_FORMAT = (
    '[%(asctime)s PID %(process)s '
    '%(filename)s:%(lineno)s - %(funcName)s()] '
    '%(levelname)s -> \n'
    '%(message)s\n'
)
logging.basicConfig(format=LOG_FORMAT)
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.propagate = False
fh = logging.FileHandler(LOG_FILE, "a")
fh.setLevel(logging.INFO)
fh.setFormatter(logging.Formatter(LOG_FORMAT))
logger.addHandler(fh)
keep_fds = [fh.stream.fileno()]

DELAY = 1
ROFI_RECORD_TRUNCATE_SIZE = 50

last_paste = ""


def watch_clipboard(*args):
    global last_paste

    clip = args[0]

    new_paste = clip.wait_for_text()
    if new_paste == last_paste:
        return

    last_paste = new_paste
    logger.info('New paste found!')
    command = 'notify-send --urgency=low "A new paste has been captured."'
    run(command, shell=True)
    with open(CLIPBOARD_HISTORY_FILE, 'a') as output_file:
        timestamp = datetime.now().strftime('%Y%m%d.%H:%M:%S.%f')
        data = {'timestamp': timestamp, 'contents': new_paste}
        output_file.write(f'{json.dumps(data)}\n')
        logger.info(
            f'Paste successfully written to file' f'{CLIPBOARD_HISTORY_FILE}'
        )


def start_daemon():
    message = (
        f'Starting gtk execution loop. '
        f'The log file is at "{LOG_FILE}", '
        f'and the clipboard history file at "{CLIPBOARD_HISTORY_FILE}".'
    )
    print(message)
    logger.info(message)
    clip = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    clip.connect('owner-change', watch_clipboard)
    Gtk.main()


def get_rofi_records():
    with open(CLIPBOARD_HISTORY_FILE, 'r') as input_file:
        file_records = input_file.readlines()

    logger.info(
        f'Found {len(file_records)} records on {CLIPBOARD_HISTORY_FILE}.'
    )

    rofi_records = []
    for record in file_records:
        parsed_record = json.loads(record)
        timestamp = parsed_record['timestamp']
        parsed_record_lines = parsed_record['contents'].split('\n')
        first_contents_line = parsed_record_lines[0]
        rofi_record = first_contents_line[0:ROFI_RECORD_TRUNCATE_SIZE]
        if len(first_contents_line) > ROFI_RECORD_TRUNCATE_SIZE:
            rofi_record += '...'
        text = 'line' if len(parsed_record_lines) == 1 else 'lines'
        rofi_record += f'  --- {len(parsed_record_lines)} {text} '
        rofi_record += f'from {timestamp}'
        rofi_records.append(rofi_record)

    return rofi_records


def get_paste_contents_from_timestamp(timestamp: str):
    with open(CLIPBOARD_HISTORY_FILE, 'r') as input_file:
        file_records = input_file.readlines()

    for record in file_records:
        parsed_record = json.loads(record)
        record_timestamp = parsed_record['timestamp']
        if record_timestamp == timestamp:
            return parsed_record['contents']

    raise Exception(f'No record found for timestamp="{timestamp}"')


def client():
    logger.info('Running client...')
    print('Showing keyboard selections...')
    rofi_records = get_rofi_records()
    rofi_records.reverse()

    rofi_client = Rofi()
    selected, keyboard_key = rofi_client.select(
        'Choose a previous paste from clipboard history',
        rofi_records,
        fullscreen=True,
    )
    logger.info(f'keyboard_key pressed={keyboard_key}')

    if keyboard_key == -1:
        logger.info('cancelled')
        sys.exit(0)

    selected_paste = rofi_records[selected]
    logger.info(f'selected_paste={selected_paste}')

    selected_paste_timestamp = selected_paste[-24:]

    contents = get_paste_contents_from_timestamp(selected_paste_timestamp)
    pyperclip.copy(contents)

    command = (
        f'notify-send --urgency=low "Paste '
        f'{selected_paste} copied to clipboard" '
    )
    run(command, shell=True)
    logger.info('Finished running client.')


def main(daemon_mode: bool = True):
    start_daemon() if daemon_mode else client()


if __name__ == '__main__':
    try:
        typer.run(main)
    except Exception as e:
        message = f'An exception was triggered: {e} '
        print(message)
        logger.exception(message)
        sys.exit(1)
