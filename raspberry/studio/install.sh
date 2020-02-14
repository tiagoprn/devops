#!/bin/bash
INSTALL_PATH=/storage/raspberry/studio
mkdir -p $INSTALL_PATH
cd $INSTALL_PATH && \
    wget https://wyliodrin-studio.s3.us-east-2.amazonaws.com/Wyliodrin+STUDIO+2.0.6-beta.AppImage && \
    chmod 700 *.AppImage && \
    wget https://wyliodrin-studio.s3.us-east-2.amazonaws.com/wyliodrin_studio_raspberrypi_zero_2019_11_21.zip && \
    wget https://wyliodrin-studio.s3.us-east-2.amazonaws.com/wyliodrin_studio_raspberrypi_2019_11_27.zip && \
    echo "Instalation finished at '$INSTALL_PATH'. Run with './Wylio...'"
