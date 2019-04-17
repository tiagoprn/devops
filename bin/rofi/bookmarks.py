#!/usr/bin/env python3

# TODO: migrate to python-rofi: https://github.com/bcbnz/python-rofi
import glob
import os
import subprocess
import sys

import dmenu
from rofi import Rofi

BROWSERS = {
    ' Firefox': 'firefox-beta',
    ' Chrome': 'google-chrome-stable'
}

BOOKMARKS_ROOT = '/storage/docs/notes'


def get_bookmark_files():
    return [filename for filename in \
            glob.iglob(f'{BOOKMARKS_ROOT}/**/.BrowserBookmarks',
                       recursive=True)]


def main():
    chosen_title = dmenu.show(urls.keys(),
                              prompt='Choose a bookmark',
                              lines=20)
    if not chosen_title:
        print('No title chosen, quitting now.')
        sys.exit(0)

    chosen_url = urls[chosen_title]
    print(f'chosen_url={chosen_url}')

    browser = dmenu.show(BROWSERS.keys(), prompt='Choose the browser:')

    if not browser:
        print('No browser chosen, quitting now.')
        sys.exit(0)

    command = f'notify-send --urgency low "Opening {browser} ' \
              f'with bookmark {chosen_title}"...'
    os.system(command)

    if 'firefox' in browser.lower():
        command = f"{BROWSERS[browser]} --new-tab {chosen_url} &"
    else:
        command = f"{BROWSERS[browser]} {chosen_url} &"
    os.system(command)


def get_bookmarks():
    global bookmarks_list, file_context, tag, url
    bookmarks_list = []
    bookmarks_urls = {}
    files = get_bookmark_files()
    for file in files:
        file_context = file.split('/')[-2]
        with open(file, 'r') as input_file:
            lines = input_file.readlines()
        for line in lines:
            if line.replace('\n', ''):
                tag, url = line.split()
                key = f'{file_context}_{tag}'
                value = url
                bookmarks_list.append(key)
                bookmarks_urls[key] = url
    return sorted(bookmarks_list), bookmarks_urls


if __name__ == "__main__":
    # main()
    bookmarks_list, bookmarks_urls = get_bookmarks()

    rofi_client = Rofi()
    selected, keyboard_key = rofi_client.select('What bookmark you want to open?',
                                                bookmarks_list)
    print(f'keyboard_key pressed={keyboard_key}')

    if keyboard_key == -1:
        print('cancelled')
        sys.exit(0)

    print('Moving on...')
    url = bookmarks_urls[bookmarks_list[selected]]

    rofi_client.status(f'Opening url: {url}')
