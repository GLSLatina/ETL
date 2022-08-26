#!/bin/bash
#
# Script che dumpa gli arrivi di domani
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
#TOMORROW=`date -d tomorrow +%m/%d/%Y`
TODAY=`date --date="2 weeks ago" +%m/%d/%Y `
DATE=`date +%D`
TIME=`date +%k`
SCRIPT=estrai_arrivi_domani.p
TMP=tmp
LOGFILE=$TMP/arrivi_domani.log

mkdir -p tmp

rm -f /u/users/t99/openedge/scripts/tmp/arrivi_domani.csv

# Fix extraction script
#sed -e "s?DATA_DA_SOSTITUIRE?$TOMORROW?g" $SCRIPT > $TMP/$SCRIPT
sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $TMP/$SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro-arrivi-domani.log
RESULT=$?
if (test "$RESULT" != "0"); then
	echo ERRORE Esportazione database da Arrivi Domani alle $DATE $TIME | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione Database Arrivi Domani" fabio.pietrosanti@glslatina.it
fi


