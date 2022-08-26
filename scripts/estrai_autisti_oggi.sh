#!/bin/bash
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
DATE=`date +%D`
TIME=`date +%k`
SCRIPT=estrai_autisti_oggi.p
TMP=tmp
mkdir -p tmp

rm -f /u/users/t99/openedge/scripts/tmp/autisti_oggi.txt

# Fix extraction script
sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $TMP/$SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro.log
RESULT=$?
if (test "$RESULT" != "0"); then
       echo ERRORE Esportazione database AUTISTI Oggi alle $DATE $TIME | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione Databse Arrivi AUTISTI" fabio.pietrosanti@glslatina.it
	exit
fi
