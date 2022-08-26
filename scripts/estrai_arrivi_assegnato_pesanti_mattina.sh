#!/bin/sh

# LOGICA:
# $9 è porto assegnato = yes
#
# $20 è provincia destinataria LT
#
# $70 è sede pagante il porta assegnato (non LT)
#
# $30 pesa più di050 KG di peso reale
# oppure
# $30 pesa più di050 KG di peso volume

if(test "$1"); then

# CLIENTI SEDE LATINA CON ARRIVI SOPRA 100KG
echo ========================================
echo "ARRIVI PORTO ASSEGNATO SEDE LATINA SOPRA 90KG"
echo ""
echo ========================================

	cat $1 | awk -Fµ  '  gsub(",",".",$30)  gsub(",",".",$31) $9~"yes" && (index($20, "LT") != 0) && ($30>90 || $31>90) { print "NSPED:",$1, "DATA:",$3, "\n","CLI:", $16, $19,"\n","PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}'  | egrep -vi 'marcopolo|unieuro|marco polo|linkem|KM. 67,500'

#	cat $1 | awk -F~  '  gsub(",",".",$30)  gsub(",",".",$31) ($9~"yes") && (index($20, "LT") != 0) && ($30>150 || $31>150) { print "NSPED:",$1, "DATA:",$3, "\n","CLI:", $16, $19,"\n","PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}'  | egrep -vi 'marcopolo|unieuro|marco polo|linkem|KM. 67,500'



else
	echo Manca nome file arrivi
fi
