#!/bin/bash
for foto in *.png; do 
    #troca o preto VERDE
    #convert "$foto" +level-colors 'rgb(0,255,0)', "$foto.OTHER.png";    
    convert "$foto" +level-colors '#000000', "$foto.OTHER.png";
done
