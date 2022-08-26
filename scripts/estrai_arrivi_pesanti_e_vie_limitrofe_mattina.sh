#!/bin/sh

# LOGICA:
# $9 è porto assegnato = yes
#
# $20 è provincia destinataria LT
#
# $70 è sede pagante il porta assegnato (non LT)
#
# $30 pesa più di150 KG di peso reale
# oppure
# $30 pesa più di150 KG di peso volume

echo ========================================
echo "ARRIVI PORTO FRANCO SEDE LATINA SOPRA 99KG"
echo ""
echo ========================================
	cat  /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt | awk -Fµ  '  gsub(",",".",$30)  gsub(",",".",$31)&& (index($20, "LT") != 0) && ($3>099 || $31>99) { print "NSPED:",$1, "DATA:",$3, "\n","CLI:", $16, $19, $17,"\n","PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}'  
#	cat $1 | awk -F~  '  gsub(",",".",$30)  gsub(",",".",$31) (index($9, "yes") != 0) && (index($20, "LT") != 0) && ($70~"LT") && ($30>100 || $31>100) { print " CLIENTE:", $16, $17, $19,"\n","FIRMA:", $77, "PESO:", $30, "VOL:", $31, "NOLO:", $34, "NSPED:",$1, "DATA:",$3, "\n","MITTENTE:", $11, $13, $15, "NOTE:", $49, "\n\n"}'  | egrep -vi 'marcopolo|unieuro|marco polo|linkem|KM. 67,500'


