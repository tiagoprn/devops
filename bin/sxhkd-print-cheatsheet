#!/usr/bin/env python3

from sys import stdout

SXHKDRC_PATH = '/storage/src/dot_files/sxhkd/sxhkdrc'

with open(SXHKDRC_PATH) as config_file:
    print_next_line = False
    new_entry = ''
    for line in config_file:
        line = line.replace('\n', '')
        is_comment_line = line.startswith('#') and line.endswith(':')

        if is_comment_line:
            print_next_line = True
            new_entry = line[0:-1].ljust(65)
        elif print_next_line:
            new_entry += f' {line}\n'
            stdout.write(new_entry[2:])
            print_next_line = False


