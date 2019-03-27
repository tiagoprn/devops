import os
import subprocess
import sys


def get_bookmarks_list():
    # output = subprocess.check_output(['/bin/bash', '/storage/src/devops/bin/bookmarks_list.sh'])
    output = subprocess.run(['/bin/bash', '/storage/src/devops/bin/bookmarks_list.sh'], stdout=subprocess.PIPE).stdout.decode('utf-8')
    return output


if __name__ == "__main__":
    bookmarks_list = get_bookmarks_list()
    lines = bookmarks_list.split('\n')

    options = {}

    for line in lines:
        splitted_line = line.split()
        if not splitted_line:
            continue
        alias = splitted_line[0]
        url = splitted_line[1]
        options[alias] = url

    dmenu_options = sorted(options.keys())

    # TODO: the menu must be piped from printing dmenu_options above. E.g. how to run on the shell:
    # $ printf 'eu\ntu\nele\n' | dmenu -b
    dmenu_output = subprocess.run(['dmenu', '-b', ''.join(dmenu_options)], stdout=subprocess.PIPE).stdout.decode('utf-8')

    # cat .BrowserBookmarks | awk '{print $1}' | dmenu -l 50 (the list lenght here)
