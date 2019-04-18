#!/usr/bin/env python3

# TODO: migrate to python-rofi: https://github.com/bcbnz/python-rofi
import glob
import os
import sys

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

    selected_bookmark = bookmarks_list[selected]
    print(f'selected_bookmark={selected_bookmark}')
    chosen_url = bookmarks_urls[selected_bookmark]
    print(f'chosen_url={chosen_url}')

    browsers = BROWSERS.keys()
    browsers_keys = []
    for index in BROWSERS:
        browsers_keys.append(index)

    selected, keyboard_key = rofi_client.select('Open on what browser?',
                                                browsers)
    print(f'keyboard_key pressed={keyboard_key}')

    if keyboard_key == -1:
        print('No browser chosen, quitting now.')
        sys.exit(0)

    print(f'selected={selected}')

    selected_browser = BROWSERS[browsers_keys[selected]]
    print(f'selected_browser={selected_browser}')
    command = f'notify-send --urgency low "Opening {selected_browser} ' \
              f'with url {selected_bookmark}"...'
    os.system(command)

    if 'firefox' in selected_browser.lower():
        command = f"{selected_browser} --new-tab {chosen_url} &"
    else:
        command = f"{selected_browser} {chosen_url} &"
    os.system(command)
