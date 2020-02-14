#!/bin/bash
INSTALL_PATH=/storage/raspberry/studio
mkdir -p $INSTALL_PATH
cd $INSTALL_PATH && \
    wget https://wyliodrin-studio.s3.us-east-2.amazonaws.com/Wyliodrin+STUDIO+2.0.6-beta.AppImage && \
    chmod 700 *.AppImage && \
    echo "Instalation finished at '$INSTALL_PATH'. Run with './Wylio...'"
