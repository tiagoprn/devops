#!/bin/bash 

#Le o arquivo "WinXP.vdi" e divide em pedacos de 3 GB (3000 MB), em "/media/Nokia N900_/tiago/projetos/04042011_1650/":
split --bytes=3000M -d WinXP.vdi "/media/Nokia N900_/tiago/projetos/04042011_1650/WinXP.vdi.PART__"; 
echo 'Concluido. Para juntar tudo novamente, faça: ============ $ "cat *PART__* > WinXP.vdi"';
