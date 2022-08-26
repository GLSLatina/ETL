#!/bin/bash

DATE=`date +%D`

cd /u/users/t99/openedge/scripts

./isole_minori_partenze.sh > tmp/isole_minori.txt

./partenze_assegnato_citta.sh > tmp/porto_assegnato_citta.txt

./provincia_partenze.sh > tmp/provincia_scs_nolight.txt


echo ISOLE MINORI > tmp/partenze_rep.txt
cat tmp/isole_minori.txt >> tmp/partenze_rep.txt
echo ""  >> tmp/partenze_rep.txt
echo PORTO ASSEGNATI CON RITIRO CITTA  >> tmp/partenze_rep.txt
cat tmp/porto_assegnato_citta.txt >> tmp/partenze_rep.txt
echo ""  >> tmp/partenze_rep.txt
echo PARTENZE PROVINCIA SCS NO-LIGHT  >> tmp/partenze_rep.txt
cat tmp/provincia_scs_nolight.txt >> tmp/partenze_rep.txt
/usr/bin/mailx -s "Report Partenze test $DATE" -r  "Report Partenze <latina@gls-italy.com>" fabio.pietrosanti@glslatina.it <  tmp/partenze_rep.txt
