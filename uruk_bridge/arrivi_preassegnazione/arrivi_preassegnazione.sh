#!/bin/bash
DOMANI=`date --date="next day"  +%d/%m/%y`
ORA=`date  +%H:%M`

EMAIL=distribuzione@glslatina.it

# If there are porti assegnati send an email


# Esegui script di analisi se file esiste

if (test -f "/tmp/arrivi_domani.csv");then

	/root/arrivi_preassegnazione/genera_preassegnazione_arrivi.sh > /tmp/arrivi_preassegnazione.txt

	/usr/bin/mailx -r "GLS-LT Arrivi <amministrazione@glslatina.it>" -s  "Arrivi $DOMANI: Ora elaborazione $ORA"  $EMAIL < /tmp/arrivi_preassegnazione.txt
fi
