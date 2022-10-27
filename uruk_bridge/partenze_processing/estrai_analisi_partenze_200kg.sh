#!/bin/sh

DATE=`date +%d-%m-%y`

# ESTRAI INDICATORI
PREANALISI=/tmp/partenze_preanalisi.txt
FORZATIEMAIL=davide.giuliani@glslatina.it


# Volume sopra i 200kg
# Eliminati i contratti 1:100
grep IND-VOLUME-OVER-200KG $PREANALISI | egrep -vi 'xlab|elleci|unipam' | sort  -k +2 |  sed -e 's/IND-VOLUME-OVER-200KG://g' > /tmp/partenze_volumesopra.txt
IND_VOLUME_OVER_200KG=`cat /tmp/partenze_volumesopra.txt |wc -l `
#
# Volume over 200KG
if(test "$IND_VOLUME_OVER_200KG" -gt "0"); then
	echo Pesanti Volume 200KG IND-VOLUME-OVER-200KG: "$IND_VOLUME_OVER_200KG"
	echo ""
	cat /tmp/partenze_volumesopra.txt | sed -e 's/IND-VOLUME-OVER-200KG://g'
	/usr/bin/mailx -r "Volume più di200kg <amministrazione@glslatina.it>" -s "Partenze: $IND_VOLUME_OVER_200K GVolume >200Kg  $DATE" $FORZATIEMAIL < /tmp/partenze_volumesopra.txt
	echo ""
fi

