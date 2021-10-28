#!/bin/bash
# Generates a random password containing uppercase and lowercase characters and digits, with the password length random varying from 10 to 20 characters
python3 -c 'import os; import random; import string; print("".join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(random.randint(10, 20))))'

