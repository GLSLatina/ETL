#!/bin/bash
# 
# INCLUDES
. /usr/softec/sienv11
export TERM=xterm
cd /u/users/t99/openedge/scripts/
TODAY=`date +%m/%d/%Y`
DATE=`date +%D`
TIME=`date +%k`
SCRIPT=estrai_arrivi_oggi.p
TMP=tmp
LOGFILE=$TMP/lead_commerciali_porti_assegnati.rtf
LOGASSEGNATO=$TMP/sped_assegnato.rtf
LOGFRANCO=$TMP/sped_franco.rtf
mkdir -p tmp

rm -f /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt

# Fix extraction script
sed -e "s?DATA_DA_SOSTITUIRE?$TODAY?g" $SCRIPT > $TMP/$SCRIPT

# Extra database arrivi for today
pro -pf sped.pf -b -p $TMP/$SCRIPT -cprcodein UTF-8 -cpstream UTF-8 > tmp/pro.log
RESULT=$?
if (test "$RESULT" != "0"); then
       echo ERRORE Esportazione database da Arrivi Oggi alle $DATE $TIME | /usr/bin/mailx -r  "Error Database <latina@gls-italy.com>" -s "ERRORE: Problema Interrogazione Databse Arrivi Oggi" fabio.pietrosanti@glslatina.it
	exit
fi


if ( [[ $TIME -ge 22 ]]); then

# process arrivi for porti assegnati
	/u/users/t99/openedge/scripts/estrai_porti_assegnati_commerciale.sh /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt > $LOGFILE
# If there are porti assegnati send an email
	if [ -s $LOGFILE ]
		then
			/usr/bin/mailx -r  "Lead Commerciali P/ASS <latina@gls-italy.com>" -s "Lead Commerciali $DATE Porto Assegnato"  commerciale@glslatina.it < $LOGFILE
			rm -f $LOGFILE
	fi

	/u/users/t99/openedge/scripts/estrai_porti_assegnati_commerciale.sh /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt > $LOGFILE
# If there are porti assegnati send an email
	if [ -s $LOGFILE ]
		then
			/usr/bin/mailx -r  "Note Spese <latina@gls-italy.com>" -s "Note Spese $DATE da Recuperare"  amministrazione@glslatina.it < $LOGFILE
			rm -f $LOGFILE
	fi

fi

# Controllo mattutino
#if ( [[ $TIME -ge 9 ]] && [[ $TIME -lt 10 ]]); then

# process arrivi for porti franco
#	/u/users/t99/openedge/scripts/estrai_arrivi_franco_pesanti_mattina.sh /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt > $LOGFRANCO
# If there are porti assegnati send an email
#	if [ -s $LOGFRANCO ]
#		then
#			/usr/bin/mailx -r  "Porti Franco Pesanti <latina@gls-italy.com>" -s "ARRIVI: Porti Franco Pesanti =>99KG $DATE" pesanti-in-arrivo@glslatina.it < $LOGFRANCO
#			rm -f $LOGFRANCO
#	fi

#fi


# Controllo mattutino
#if ( [[ $TIME -ge 9 ]] && [[ $TIME -lt 10 ]] ); then

# process arrivi for porti assegnati
#	/u/users/t99/openedge/scripts/estrai_arrivi_assegnato_pesanti_mattina.sh /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt > $LOGASSEGNATO
# If there are porti assegnati send an email
#	if [ -s $LOGASSEGNATO ]
#		then
#			/usr/bin/mailx -r  "Porti Assegnato Pesanti <latina@gls-italy.com>" -s "ARRIVI: Porti Assegnati Pesanti =>90KG $DATE" pesanti-in-arrivo@glslatina.it < $LOGASSEGNATO
#			rm -f $LOGASSEGNATO
#	fi

#fi










##echo "In seguito i porti assegnati del giorno da contattare:" > $LOGFILE
#echo "" >> $LOGFILE
#./estrai_porti_assegnati_commerciale.sh arrivi_oggi.txt  >> $LOGFILE

#/usr/bin/mailx -r  "Lead Commerciali P/ASS <latina@gls-italy.com>" -s "Lead Commerciali $DATE Porto Assegnato"  commerciale@glslatina.it < $LOGFILE
