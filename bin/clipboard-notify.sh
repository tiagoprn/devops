#!/bin/bash

echo "Script $0 started..."
notify-send -u normal -t 3000 -i info 'Script Started!' $0

clip_command="xclip -selection clipboard -o"
current_value=`$clip_command`

while true
do
   new_value=`$clip_command`

   if [[ ! ("$current_value" == "$new_value") ]];
   then
      notify-send 'Clipboard was updated.' --urgency low

      current_value=$new_value
   else
      echo "Polling the clipboard..."
   fi

   sleep 1
done

