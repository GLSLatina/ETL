#!/bin/bash
# controllo partenze assegnato con mittente citta'
#

awk -Fµ ' gsub(",",".",$46) ($9~"yes") &&  ( ($2~"10") || ($2~"2") ) && ($12~"04100") && ($11!~"GLS") { print $1,$9,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$30,$31,$44,$45,$46}'  tmp/partenze_oggi.csv   

