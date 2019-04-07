import os
import subprocess
import sys

import dmenu


BROWSERS=['firefox', 'google-chrome-stable']

# To use, install as root:
# sudo pip3 install dmenu

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
            print(line)
            title, url = line.split()
            urls[title] = url

    chosen_title = dmenu.show(urls.keys(), prompt='Choose a bookmark')
    if chosen_title:
        chosen_url = urls[chosen_title]
        print(chosen_url)

    browser = dmenu.show(BROWSERS, prompt='Choose the browser:')

    if browser:
        command = f'notify-send --urgency low "opening {browser} with bookmark {chosen_title}"...'
        os.system(command)

        if browser == 'firefox':
            command = f'{browser} --new-tab {chosen_url} &'
        else:
            command = f'{browser} {chosen_url} &'
        os.system(command)
