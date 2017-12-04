#!/bin/bash

OUT_DIR=novas

PAD_LENGTH=5

if [ -z "$1" ] || [ -z "$2" ] ; then
   echo "./renomear_imagens_recursivamente.sh <number-to-start-from> <extension>"
   echo " "
   echo "./renomear_imagens_recursivamente.sh 12 JPG"
else
   # testing output directory exist. if not create it.
   if [ ! -d ${OUT_DIR} ] ; then
      mkdir ${OUT_DIR}
   fi

   COUNTER=$1
   EXT=$2

   for file in *.${EXT} ; do
      OUTFILE=$(printf "%0${PAD_LENGTH}i\n" "${COUNTER}")
      cp -v "$file" "${OUT_DIR}/${OUTFILE}.${EXT}";
      let COUNTER++;
   done
fi
