#!/usr/bin/env python3

# TODO: migrate to python-rofi: https://github.com/bcbnz/python-rofi

import os
import subprocess
import sys

import dmenu
import rofi


BROWSERS = {
    ' Firefox': 'firefox-beta',
    ' Chrome': 'google-chrome-stable'
}



def get_bookmarks_list():
    # output = subprocess.check_output(['/bin/bash', '/storage/src/devops/bin/bookmarks_list.sh'])
    output = subprocess.run(['/bin/bash', '/storage/src/devops/bin/bookmarks_list.sh'], stdout=subprocess.PIPE).stdout.decode('utf-8')
    return output


if __name__ == "__main__":
    bookmarks_list = get_bookmarks_list()
    lines = bookmarks_list.split('\n')

    urls = {}

    for line in lines:
        if line.replace('\n', ''):
            title, url = line.split()
            urls[title] = url

    chosen_title = dmenu.show(urls.keys(), prompt='Choose a bookmark', lines=20)
    if not chosen_title:
        print('No title chosen, quitting now.')
        sys.exit(0)

    chosen_url = urls[chosen_title]
    print(f'chosen_url={chosen_url}')

    browser = dmenu.show(BROWSERS.keys(), prompt='Choose the browser:')

    if not browser:
        print('No browser chosen, quitting now.')
        sys.exit(0)

    command = f'notify-send --urgency low "Opening {browser} with bookmark {chosen_title}"...'
    os.system(command)

    if 'firefox' in browser.lower():
        command = f"{BROWSERS[browser]} --new-tab {chosen_url} &"
    else:
        command = f"{BROWSERS[browser]} {chosen_url} &"
    os.system(command)

