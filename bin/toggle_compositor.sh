#!/bin/bash
pid=$(ps aux | grep [c]ompton | awk '{print $2}')  # the [c] on the beginning of the program name assures it does not include the own grep pid on the output
if [ -z "$pid" ]
then
    echo 'Compton not running, will run it.';
    compton --config ~/compton.conf &
else
    echo 'Compton running, will kill it!'
    kill $pid
fi    
