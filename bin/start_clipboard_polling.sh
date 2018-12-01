#!/bin/bash

script_path=/storage/src/devops/bin/clipboard-notify.sh

function IsClipboardPollingRunning
{
   if (ps -A | grep -q "clipboard-notify")
   then
      return 1;
   else
      return 0;
   fi
}

if (IsClipboardPollingRunning == 0)
then
   echo "Starting $script_path"
   nohup $script_path &
else
   echo "$script_path is already running"
   notify-send -u normal -t 3000 -i info 'Clipboard Notify' "$script_path is already running."
fi
