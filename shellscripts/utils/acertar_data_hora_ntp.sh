#!/bin/bash
# PARA ESTE SCRIPT FUNCIONAR, É NECESSÁRIO TER INSTALADO O PACOTE 'ntp'.
echo 'Acertando a hora de acordo com o servidor ntp da USP...';
ntpdate -s pool.ntp.br;
echo 'CONCLUÍDO!';
