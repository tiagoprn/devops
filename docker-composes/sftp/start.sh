#!/bin/bash

if ( id ${USER} ); then
    echo "INFO: User ${USER} already exists."
else
    echo "INFO: User ${USER} does not exists, will create it..."
    ENC_PASS=$(perl -e 'print crypt($ARGV[0], "password")' ${PASS})
    echo "Setting up the 'transfer' group..."
    addgroup transfer
    echo "Creating the user..."
    useradd -d /home/${USER} -m -p ${ENC_PASS} -u ${USER_UID} -s /bin/sh ${USER}
    usermod -G transfer ${USER}
    echo "Jailing the user inside its home folder..."
    # Below will "jail" the user inside its home, not allowing him to go
    # outside this directory. He will only be able to manage the files inside
    # the "public" folder.
    chown root:root /home/${USER}
    chmod 755 /home/${USER}
    mkdir /home/${USER}/public
    chown ${USER}:transfer /home/${USER}/public
    echo "User setup finished."
fi

echo "SFTP server (through openssh) ready. Enjoy :)"

exec /usr/sbin/sshd -D
