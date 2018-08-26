#!/bin/bash
pid=$(ps aux | grep [c]ompton | awk '{print $2}')
if [ -z "$pid" ]
then
    echo 'Compton not running, will run it.';
    compton --config ~/compton.conf &
else
    echo 'Compton running, will kill it!'
    kill $pid
fi    
