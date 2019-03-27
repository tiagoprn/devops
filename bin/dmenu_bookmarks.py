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

    for line in lines:
        print(line)

    # TODO: call fzf and dmenu like on the shellscript "search_posts_and_trigger_vim_by_file_contents.sh"
