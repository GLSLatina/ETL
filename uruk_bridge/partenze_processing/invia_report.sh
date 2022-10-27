#!/bin/sh

MSGFILE=/tmp/partenze_report_email.txt


cat /tmp/partenze_analisi.txt > $MSGFILE
echo "" >> $MSGFILE
echo INDIRIZZI FORZATI >> $MSGFILE
echo "" >> $MSGFILE
cat /tmp/partenze_forzati.txt | sed -e 's/IND-FORZATI://'>> $MSGFILE
echo "" >> $MSGFILE
echo WEBLABELING MANCANTI >> $MSGFILE
echo "" >> $MSGFILE
cat /tmp/partenze_weblabeling.txt | sed -e 's/NON-WEBLABELING://' >> $MSGFILE
echo "" >> $MSGFILE
echo TELEFONO MANCANTE IN CAMPO NOTE >> $MSGFILE
echo "" >> $MSGFILE
cat /tmp/partenze_note.txt | sed -e 's/NON-TEL-NOTE://' >> $MSGFILE
echo "" >> $MSGFILE
echo INDIRIZZI SENZA VIRGOLA PRIMA DEL CIVICO >> $MSGFILE
echo "" >> $MSGFILE
cat /tmp/partenze_virgola.txt | sed -e 's/IND-VIRGOLA://' >> $MSGFILE

/usr/bin/mailx -r "Partenze Porto Franco <amministrazione@glslatina.it>" -s "Controllo Partenze Porto Franco" -a /tmp/partenze_note.txt -a /tmp/partenze_weblabeling.txt -a /tmp/partenze_forzati.txt -a /tmp/partenze_virgola.txt fabio.pietrosanti@glslatina.it < $MSGFILE

