"""
This is a daemon that must be run on background
when the window manager starts.

It writes the clipboard entries to a file, which
can be fed to dmenu/rofi so that we can select
past entries.

The idea is to be KISS. No bloated features here.

It requires a 3rd party pypi library named `daemonize`.

To interact with the keyboard, it requires the 3rd party
pypi library named "pyperclip".

TODO:

- The script will have 2 modes of execution: daemon and client, passed by the
  command line as arguments. When running as daemon, must run the current
  daemon.start function, when in client mode it must run the functions
  described below:


- Make a function to return a transformed list of dicts of every record found at
  ~/clipboard.history.  If a record has more than one line, it returns only the
  first line and the total lines of the record. E.g:

[
    {'20200101-150000-000': 'ls -la (1/99)'},
    {'20200101-150000-345': 'df -m (1/5)'},
    {'20200101-150000-345': 'uname -r (1/1)'}
]

  This function output must be passed to rofi so that I can get a list of all
  records available to pasting.

  After selecting a record from the rofi list, I must call another function to
  select one element from the list by its' timestamp. When selected, it will
  return the full contents of the record, and copy it to the clipboard through
  pyperclip. E.g.:

  # copying text to clipboard
  pc.copy(text1)

  # pasting the text from clipboard
  text2 = pc.paste()


- remove clipmenu from my github repository.
"""
import json
import logging
import os
import sys
from datetime import datetime
from time import sleep

import pyperclip
from daemonize import Daemonize

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


def watch_clipboard():
    try:
        new_paste = pyperclip.waitForNewPaste(timeout=DELAY)
        if not new_paste:
            logger.info('No new paste found on this loop.')
            return
    except pyperclip.PyperclipTimeoutException:
        logger.info('No new paste found on this loop after timeout.')
        return

    logger.info('New paste found!')
    with open(CLIPBOARD_HISTORY_FILE, 'a') as output_file:
        data = {'timestamp': '', 'contents': new_paste}
        output_file.write(f'{json.dumps(data)}\n')
        logger.info(
            f'Paste successfully written to file' f'{CLIPBOARD_HISTORY_FILE}'
        )


def loop():
    logger.info('Entering execution loop...')
    while True:
        try:
            logger.info('Checking for new paste on clipboard...')
            watch_clipboard()
            # logger.info(f'Sleeping for {DELAY} seconds...')
            # sleep(DELAY)
        except Exception as e:
            logger.exception('An exception has occurred: {e}')


def start_daemon():
    message = (
        f'Starting daemon with pidfile="{PIDFILE}". '
        f'The log file is at "{LOG_FILE}", '
        f'and the clipboard history file at "{CLIPBOARD_HISTORY_FILE}".'
    )
    print(message)
    logger.info(message)

    daemon = Daemonize(
        app=CURRENT_SCRIPT_NAME, pid=PIDFILE, keep_fds=keep_fds, action=loop,
    )
    daemon.start()


def main():
    start_daemon()


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        message = f'An exception was triggered: {e} '
        print(message)
        logger.exception(message)
        sys.exit(1)
