#!/bin/sh

DATE=`date +%d-%m-%y`

# ESTRAI INDICATORI
PREANALISI=/tmp/partenze_preanalisi_assegnato.txt
FORZATIEMAIL=controllopartenze@glslatina.it


# INDICATORI QUALITATIVI
#
# Spedizioni con PESO 1 e VOLUME 0
grep IND-UNO-ZERO $PREANALISI  | sort  -k +2 > /tmp/partenze_unozero_assegnato.txt
IND_UNO_ZERO=`cat /tmp/partenze_unozero_assegnato.txt |grep -vi GLS | wc -l `

# Spedizioni con PESO 10 e VOLUME 0
grep IND-DIECI-UNO $PREANALISI  | sort  -k +2 > /tmp/partenze_dieciuno_assegnato.txt
IND_DIECI_UNO=`cat /tmp/partenze_dieciuno_assegnato.txt |wc -l `


if(test "$IND_UNO_ZERO" -gt "0"); then
	echo Peso 1 e Volume a 0 Porto Assegnato IND-UNO-ZERO-PESO-E-VOLUME: "$IND_UNO_ZERO"
	echo ""
	cat /tmp/partenze_unozero_assegnato.txt | sed -e 's/IND-UNO-ZERO-PESO-E-VOLUME://g' | grep -vi GLS
	echo "Ci sono spedizioni bollettate manualmente senza peso inserito" > /tmp/partenze_unozero_clean_assegnato.txt
	echo "Porre attenzione all inserimento di peso nella bollettazione manuale" >> /tmp/partenze_unozero_clean_assegnato.txt
	echo "" >>  /tmp/partenze_unozero_clean_assegnato.txt
	cat /tmp/partenze_unozero_assegnato.txt | sed -e 's/IND-UNO-ZERO-PESO-E-VOLUME://g' | grep -vi GLS >> /tmp/partenze_unozero_clean_assegnato.txt
	/usr/bin/mailx -r "Porto Assegnato Peso 1 e Volume a 0 <amministrazione@glslatina.it>" -s "Controllo Bollettazione Manuale Assegnato $IND_UNO_ZERO Peso 1 e Volume a 0 $DATE" $FORZATIEMAIL < /tmp/partenze_unozero_clean_assegnato.txt
	/usr/bin/mailx -r "Assegnato Peso 1 e Volume a 0 <amministrazione@glslatina.it>" -s "Controllo Bollettazione Assegnato $IND_UNO_ZERO Peso 1 e Volume a 0 $DATE" operativo@glslatina.it < /tmp/partenze_unozero_clean_assegnato.txt
	echo ""
fi


exit
