"""
More examples at: https://github.com/bcbnz/python-rofi
"""

import os

from rofi import Rofi

r = Rofi()
name = r.text_entry('What is your name? ')

os.system(f'notify-send --urgency low "You entered name {name}"')

