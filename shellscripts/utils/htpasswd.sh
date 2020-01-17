#!/bin/bash

#!/bin/bash

SYNTAX="./htpasswd.sh -u USERNAME -p PASSWORD"

DEFAULT_OUTPUT_FILE=/tmp/htpasswd

while getopts u:p: option; do
	case $option in
		u) USERNAME=${OPTARG};;
		p) PASSWORD=${OPTARG};;
	esac
done

echo 'Parsing script parameters...'
if [[ -z $USERNAME ]]; then
	echo -e "Missing -u parameter. Syntax: \n\n$SYNTAX\n";
	exit 1
fi

if [[ -z $PASSWORD ]]; then
	echo -e "Missing -p parameter. Syntax: \n\n$SYNTAX\n";
	exit 1
fi

echo 'Script parameters validation finished.'

echo 'Downloading docker container...' &&\
docker pull xmartlabs/htpasswd &&\
echo 'Docker container download finished. Running htpasswd command...' &&\
docker run --rm -ti xmartlabs/htpasswd $USERNAME $PASSWORD >> $DEFAULT_OUTPUT_FILE &&\
echo
echo -e "Finished. Check file $DEFAULT_OUTPUT_FILE."
echo
