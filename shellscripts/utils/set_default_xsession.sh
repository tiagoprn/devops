#!/bin/bash
# this example sets the session "kodi" as default for the user 1001. 
dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User1001 org.freedesktop.Accounts.User.SetXSession string:kodi
