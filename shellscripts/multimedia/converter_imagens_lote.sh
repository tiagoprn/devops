#!/bin/bash
for foto in *.png; do 
    #echo "ORIGINAL: $foto ; NOVO: $foto.NEW.png";    
    convert -resize 30x30 "$foto" "$foto.NEW.png";
done
