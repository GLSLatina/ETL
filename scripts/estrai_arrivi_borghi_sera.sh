#!/bin/sh

# LOGICA:
# $9 è porto assegnato = yes
#
# $20 è provincia destinataria LT
#
# $70 è sede pagante il porta assegnato (non LT)
#
# TODO: E non sono light
#
# TODO: E non sono da sede rettificatrice

if(test "$1"); then

# CLIENTI SEDE LATINA CON ARRIVI SOPRA 150KG
echo ========================================
echo "ARRIVI DESTINATI BORGHI PORTO FRANCO"
echo ""
echo ========================================

cat $1 | awk -F~  ' $9~"no" && (index($20, "LT") != 0) { print "NSPED:",$4"-"$1,"LOC:",$19, "DEST:",$16, $17" P:",$30, "V:", $31, "C:",$29 }'   | egrep -i 'Acciarella|"Borgo Bainsizza"|"Borgo Carso"|"Borgo Faiti"|"Borgo Grappa"|"Borgo Isonzo"|"Borgo Montello"|"Borgo Podgora"|"Borgo Sabotino"|"Borgo San Michele"|"Borgo SanMichele"|"Borgo Santa Maria"|"Le Ferriere"|"Tor Tre Ponti"' | egrep -vi 'fermo deposito'


#	cat $1 | awk -F~  '  gsub(",",".",$30)  gsub(",",".",$31) ($9~"yes") && (index($20, "LT") != 0) && ($30>150 || $31>150) { print "NSPED:",$1, "DATA:",$3, "\n","CLI:", $16, $19,"\n","PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}'  | egrep -vi 'marcopolo|unieuro|marco polo|linkem|KM. 67,500'



else
	echo Manca nome file arrivi
fi
