#!/bin/bash
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
TODAY=`date +%m/%d/%Y`
DATE=`date +%D`
SCRIPT=estrai_partenze_solo_oggi.p
TMP=tmp
LOGFILE=$TMP/log_partenze.log
mkdir -p tmp

# Fix extraction script
sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $TMP/$SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro.log
RESULT=$?
if (test "$RESULT" != "0"); then
       echo ERRORE Esportazione database da Partenze Oggi alle $DATE $TIME | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione Databse Partenze oggi" fabio.pietrosanti@glslatina.it
	exit
fi

# process arrivi for porti assegnati
#/u/users/t99/openedge/scripts/estrai_porti_assegnati_commerciale.sh /u/users/t99/openedge/scripts/arrivi_oggi.txt > $LOGFILE
# If there are porti assegnati send an email
#if [ -s $LOGFILE ]
#	then
#		/usr/bin/mailx -r  "Lead Commerciali P/ASS <latina@gls-italy.com>" -s "Lead Commerciali $DATE Porto Assegnato"  commerciale@glslatina.it < $LOGFILE
#fi

##echo "In seguito i porti assegnati del giorno da contattare:" > $LOGFILE
#echo "" >> $LOGFILE
#./estrai_porti_assegnati_commerciale.sh arrivi_oggi.txt  >> $LOGFILE

#/usr/bin/mailx -r  "Lead Commerciali P/ASS <latina@gls-italy.com>" -s "Lead Commerciali $DATE Porto Assegnato"  commerciale@glslatina.it < $LOGFILE
