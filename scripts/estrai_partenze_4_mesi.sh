#!/bin/bash
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
TODAY=`date --date="4 months ago" +%m/%d/%Y`
DATE=`date +%D`
SCRIPT=estrai_partenze_4_mesi.p
TMP=tmp
LOGFILE=$TMP/log_partenze_4_mesi.log
mkdir -p tmp

# Fix extraction script
sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $TMP/$SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro.log
RESULT=$?
if (test "$RESULT" != "0"); then
       echo ERRORE Esportazione database da Partenze Ultimi 4 mesi | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione DB Partenze Ultimi 4 Mesi" fabio.pietrosanti@glslatina.it
	exit
fi

