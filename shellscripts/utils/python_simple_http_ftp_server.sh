#!/bin/bash 
echo '-------------------------------------------'
echo 'NOTE: Put this script on the folder where you want to share the files.'
echo 'They will be at:'
echo '    $ http://[your-ip]:60000'
echo '-------------------------------------------'
python -m SimpleHTTPServer 60000

