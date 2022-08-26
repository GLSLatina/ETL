#!/bin/sh
# LOGICA:
# $9 è porto assegnato = yes
# $20 è provincia destinataria LT
# $70 è sede pagante il porta assegnato (non LT)
# $34 è la NOTA SPESE ed è => 20 euro

if(test "$1"); then

	cat $1 | awk -Fµ ' (index($9, "yes") != 0) && (index($20, "LT") != 0) && ($70!~"LT") && ($34>10) { print " PORTO ASSEGNATO:", $16, $17, $19,"\n","FIRMA:", $77, "PESO:", $30, "VOL:", $31, "NOLO:", $34, "NSPED:",$1, "DATA:",$3, "\n","MITTENTE:", $11, $13, $15, "NOTE:", $49, "\n\n"}'  | egrep -vi 'marcopolo|unieuro|marco polo|linkem|KM. 67,500' 

else
	echo Manca nome file arrivi
fi
