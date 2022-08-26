#!/bin/bash
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
TODAY=`date --date="4 months ago" +%m/%d/%Y`
DATE=`date +%D`
SCRIPT=estrai_rettifiche.p
TMP=tmp
LOGFILE=$TMP/log_estrai_rettifiche.log
mkdir -p tmp

# Fix extraction script
# sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro.log
RESULT=$?
if (test "$RESULT" != "0"); then
       echo ERRORE Esportazione rettifiche | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione DB Rettifiche" fabio.pietrosanti@glslatina.it
	exit
fi

