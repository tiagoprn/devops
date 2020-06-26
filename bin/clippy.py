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

#TODO after finishing up:
- remove clipmenu from my github repository.
- extract an example "daemon" script from here
and put it on my experiments/micro repository.
"""
import logging
import os
import sys
from datetime import datetime
from time import sleep

from daemonize import Daemonize

CURRENT_SCRIPT_NAME = os.path.splitext(os.path.basename(__file__))[0]

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
fh = logging.FileHandler(f'/tmp/{CURRENT_SCRIPT_NAME}.log', "a")
fh.setLevel(logging.INFO)
fh.setFormatter(logging.Formatter(LOG_FORMAT))
logger.addHandler(fh)
keep_fds = [fh.stream.fileno()]

PIDFILE = f'/tmp/{CURRENT_SCRIPT_NAME}.pid'

DELAY = 3


def main():
    while True:
        try:
            with open('/tmp/testing.txt', 'a') as output_file:
                message = f'NOW: {datetime.now().isoformat()} '
                output_file.write(f'{message}\n')

            logger.info(f'Sleeping for {DELAY} seconds...')
            sleep(DELAY)
        except Exception as e:
            logger.exception('An exception has occurred: {e}')


daemon = Daemonize(
    app=CURRENT_SCRIPT_NAME, pid=PIDFILE, keep_fds=keep_fds, action=main
)
daemon.start()


"""
import pyperclip as pc

text1 = "GeeksforGeeks"

# copying text to clipboard
pc.copy(text1)

# pasting the text from clipboard
text2 = pc.paste()

print(text2)
"""
