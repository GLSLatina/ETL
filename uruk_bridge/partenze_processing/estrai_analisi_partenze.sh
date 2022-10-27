#!/bin/sh

DATE=`date +%d-%m-%y`

# ESTRAI INDICATORI
PREANALISI=/tmp/partenze_preanalisi.txt
FORZATIEMAIL=controllopartenze@glslatina.it


# INDICATORI QUALITATIVI
#
# FORZATI
grep IND-FORZATI $PREANALISI  | sort  -k +2 > /tmp/partenze_forzati.txt
IND_FORZATI=`cat /tmp/partenze_forzati.txt |wc -l `

#
# PESO E VOLUME A ZERO
grep IND-ZERO-PESO-E-VOLUME $PREANALISI  | sort  -k +2 > /tmp/partenze_zeropesovolume.txt
IND_ZERO_PESO_E_VOLUME=`cat /tmp/partenze_zeropesovolume.txt |wc -l `
# 
# Pesanti =>30Kg senza Volume
grep IND-PESANTI-SENZA-VOLUME-O-REALE $PREANALISI  | sort  -k +2 > /tmp/partenze_pesantinovolume.txt
IND_PESANTI_SENZA_VOLUME_O_REALE=`cat /tmp/partenze_pesantinovolume.txt |wc -l `
#
# MANCA VIRGOLA INDIRIZZO
grep IND-VIRGOLA $PREANALISI  | sort  -k +2 > /tmp/partenze_virgola.txt
IND_VIRGOLA=`cat /tmp/partenze_virgola.txt |wc -l `
#
# MANCA NUMERO CIVICO
grep IND-NUMERO $PREANALISI  | sort  -k +2 > /tmp/partenze_numerocivico.txt
IND_NUMERO=`cat /tmp/partenze_numerocivico.txt |wc -l `
#
# WEBLABELING MANCANTE
grep NON-WEBLABELING $PREANALISI  | sort  -k +2 > /tmp/partenze_weblabeling.txt
NON_WEBLABELING=`cat /tmp/partenze_weblabeling.txt |wc -l `
#
# NOTE senza numero di TELEFONO
grep NON-TEL-NOTE $PREANALISI  | sort  -k +2 > /tmp/partenze_notetelefono.txt
NON_TEL_NOTE=`cat /tmp/partenze_notetelefono.txt |wc -l `
#
# EMAIL DESTINATARIO
grep NON-EMAIL-DEST $PREANALISI  | sort  -k +2 > /tmp/partenze_emaildest.txt
NON_EMAIL_DEST=`cat /tmp/partenze_emaildest.txt |wc -l `
#
# EMAIL MITTENTE
grep NON-EMAIL-MITT $PREANALISI  | sort  -k +2 > /tmp/partenze_emailmitt.txt
NON_EMAIL_MITT=`cat /tmp/partenze_emailmitt.txt |wc -l `
#
# TEL DESTINATARIO
grep NON-TEL-DEST $PREANALISI  | sort  -k +2 > /tmp/partenze_teldest.txt
NON_TEL_DEST=`cat /tmp/partenze_teldest.txt |wc -l `
#
# TEL MITTENTE
grep NON-TEL-MITT $PREANALISI  | sort  -k +2 > /tmp/partenze_telmitt.txt
NON_TEL_MITT=`cat /tmp/partenze_telmitt.txt |wc -l `


# INDICATORI ECONOMICI
#
# LIGHT oltre 3KG
grep IND-LIGHT-OLTRE-3KG $PREANALISI | sort  -k +2 > /tmp/partenze_lightoltre.txt
IND_LIGHT_OLTRE_3KG=`cat /tmp/partenze_lightoltre.txt |wc -l `
#
# NON LIGHT sotto 3KG
echo "Per ogni spedizione da 3kg su un contratto non-light spendiamo 0.58 euro di sovraccosti" > /tmp/partenze_lightsotto.txt
echo "Variare agevolazione volumetrica da standard a per fasce per i seguenti contratti, con richiesta a GLS, in seguito attivazione light e in seguito configurazione su URUK" >> /tmp/partenze_lightsotto.txt
grep IND-NO-LIGHT-MENO-3KG $PREANALISI | sort  -k +2 | sed -e 's/IND-NO-LIGHT-MENO-3KG://g' >> /tmp/partenze_lightsotto.txt
IND_NO_LIGHT_MENO_3KG=`cat /tmp/partenze_lightsotto.txt |wc -l `
#
# Pesanti sopra i 90Kg
grep IND-PESANTI-OVER-90KG $PREANALISI | sort  -k +2 > /tmp/partenze_pesantisopra.txt
IND_PESANTI_OVER_90KG=`cat /tmp/partenze_pesantisopra.txt |wc -l `
#
# Volume sopra i 200kg
# Eliminati i contratti 1:100
grep IND-VOLUME-OVER-200KG $PREANALISI | egrep -vi 'xlab|elleci|unipam' | sort  -k +2 |  sed -e 's/IND-VOLUME-OVER-200KG://g' > /tmp/partenze_volumesopra.txt
IND_VOLUME_OVER_200KG=`cat /tmp/partenze_volumesopra.txt |wc -l `
#
# Contratti bloccati
grep IND-BLOCCATO $PREANALISI | sort  -k +2 > /tmp/partenze_bloccati.txt
IND_BLOCCATO=`cat /tmp/partenze_bloccati.txt |wc -l `
#
# Ottimizzabili a volume => 10KG su 1:300
grep IND-OTTIMIZZA-VOLUME-STANDARD $PREANALISI | sort  -k +2 > /tmp/partenze_volumestandard.txt
IND_OTTIMIZZA_VOLUME_STANDARD=`cat /tmp/partenze_volumestandard.txt |wc -l `
#
# Ottimizzabili a volume => 10KG su 1:300
grep IND-OTTIMIZZA-VOLUME-EXTRA $PREANALISI | sort  -k +2 > /tmp/partenze_volumeextra.txt
IND_OTTIMIZZA_VOLUME_EXTRA=`cat /tmp/partenze_volumeextra.txt |wc -l `
#
# Spedizioni NON-LIGHT con  PESO/VOLUME rettificabili da destino con pesa automatica
grep IND-MODIFICABILI-PESA-AUTOMATICA $PREANALISI | sort  -k +2 > /tmp/partenze_modpesaautomatica.txt
IND_MODIFICABILI_PESA_AUTOMATICA=`cat /tmp/partenze_modpesaautomatica.txt |wc -l `
#
# Spedizioni NON-LIGHT con PESO/VOLUME rettificabili da destino con PES1/PES2 manualmente
grep IND-MODIFICABILI-MANUALMENTE $PREANALISI | sort  -k +2 > /tmp/partenze_modpesamanuale.txt
IND_MODIFICABILI_MANUALMENTE=`cat /tmp/partenze_modpesamanuale.txt |wc -l `
#
# Spedizioni con PESO 1 e VOLUME 0
grep IND-UNO-ZERO $PREANALISI  | sort  -k +2 > /tmp/partenze_unozero.txt
IND_UNO_ZERO=`cat /tmp/partenze_unozero.txt |wc -l `
# Spedizioni con PESO 1 e VOLUME 0
grep IND-UNO-UNO $PREANALISI  | sort  -k +2 > /tmp/partenze_unouno.txt
IND_UNO_UNO=`cat /tmp/partenze_unouno.txt |wc -l `


	echo "" > /tmp/partenze_sintesi.txt
	echo SINTESI INDICATORI >>/tmp/partenze_sintesi.txt
	echo "" >>/tmp/partenze_sintesi.txt
	echo INDICATORI QUALITATIVI >>/tmp/partenze_sintesi.txt
	echo "" >>/tmp/partenze_sintesi.txt
	echo "Indirizzi forzati   :" "$IND_FORZATI" >>/tmp/partenze_sintesi.txt
	echo "Peso e Volume a 0   :" "$IND_ZERO_PESO_E_VOLUME" >>/tmp/partenze_sintesi.txt
	echo "Senza Volume >30kg  :" "$IND_PESANTI_SENZA_VOLUME_O_REALE" >>/tmp/partenze_sintesi.txt
	echo "Indirizzi no virgola:" "$IND_VIRGOLA" >>/tmp/partenze_sintesi.txt
	echo "Indirizzi no civico :" "$IND_NUMERO" >>/tmp/partenze_sintesi.txt
	echo "Bolle NO WebLabeling:" "$NON_WEBLABELING" >>/tmp/partenze_sintesi.txt
	echo "Note senza Telefono :" "$NON_TEL_NOTE" >>/tmp/partenze_sintesi.txt
	echo "No Email Dest       :" "$NON_EMAIL_DEST" >>/tmp/partenze_sintesi.txt
#	echo "No Email Mittente   :" "$NON_EMAIL_MITT" >>/tmp/partenze_sintesi.txt
	echo "No Tel Dest         :" "$NON_TEL_DEST" >>/tmp/partenze_sintesi.txt
#	echo "No Tel Mittente     :" "$NON_TEL_MITT" >>/tmp/partenze_sintesi.txt
	echo "" >>/tmp/partenze_sintesi.txt
	echo INDICATORI ECONOMICI >>/tmp/partenze_sintesi.txt
	echo "" >>/tmp/partenze_sintesi.txt
#	echo "Peso >3.5KG Light     :" "$IND_LIGHT_OLTRE_3KG" >>/tmp/partenze_sintesi.txt
#	echo "Peso <3.5Kg NO Light  :" "$IND_NO_LIGHT_MENO_3KG" >>/tmp/partenze_sintesi.txt
	echo "Peso 1 Volume 0         :" "$IND_UNO_ZERO" >>/tmp/partenze_sintesi.txt
	echo "Peso 1 Volume 1         :" "$IND_UNO_UNO" >>/tmp/partenze_sintesi.txt
	echo "Pesanti >90KG         :" "$IND_PESANTI_OVER_90KG" >>/tmp/partenze_sintesi.txt
	echo "Volume >200KG         :" "$IND_VOLUME_OVER_200KG" >>/tmp/partenze_sintesi.txt
	echo "Sped Clienti Bloccati :" "$IND_BLOCCATO" >>/tmp/partenze_sintesi.txt
#	echo "Ottimizza Volume      :" "$IND_OTTIMIZZA_VOLUME_STANDARD" >>/tmp/partenze_sintesi.txt
#	echo "Ottimizza Volume Extra:" "$IND_OTTIMIZZA_VOLUME_EXTRA" >>/tmp/partenze_sintesi.txt
#	echo "Sped Rett. pesa auto  :" "$IND_MODIFICABILI_PESA_AUTOMATICA" >>/tmp/partenze_sintesi.txt
#	echo "Sped Rett. pesa manual:" "$IND_MODIFICABILI_MANUALMENTE" >>/tmp/partenze_sintesi.txt
	echo "" >>/tmp/partenze_sintesi.txt
#	echo DETTAGLIO INDICATORI
#	echo ""
#	echo ""
#	echo DETTAGLIO INDICATORI QUALITATIVI
#	echo ""

cat /tmp/partenze_sintesi.txt

/usr/bin/mailx -r "Sintesi Indicatori Partenze <amministrazione@glslatina.it>" -s "Partenze: Sintesi Indicatori $DATE" $FORZATIEMAIL < /tmp/partenze_sintesi.txt


if(test "$IND_FORZATI" -gt "0"); then
	echo Indirizzi forzati "IND-FORZATI": "$IND_FORZATI"
	echo ""
	cat /tmp/partenze_forzati.txt | sed -e 's/IND-FORZATI://g'
	cat /tmp/partenze_forzati.txt | grep -i vic > /tmp/partenze_forzati_vic.txt
	cat /tmp/partenze_forzati.txt | grep -iv vic > /tmp/partenze_forzati_novic.txt
	/usr/bin/mailx -r "Indirizzi Forzati <amministrazione@glslatina.it>" -s "Partenze: $IND_FORZATI Indirizzi Forzati $DATE" $FORZATIEMAIL < /tmp/partenze_forzati.txt
	/usr/bin/mailx -r "Indirizzi Forzati <amministrazione@glslatina.it>" -s "Partenze: $IND_FORZATI Indirizzi Forzati $DATE" operativo@glslatina.it < /tmp/partenze_forzati_novic.txt
	/usr/bin/mailx -r "Indirizzi Forzati <amministrazione@glslatina.it>" -s "Partenze: $IND_FORZATI Indirizzi Forzati $DATE" vic@glslatina.it < /tmp/partenze_forzati_vic.txt

	echo ""
fi
if(test "$IND_ZERO_PESO_E_VOLUME" -gt "0"); then
	echo Peso e Volume a 0 IND-ZERO-PESO-E-VOLUME: "$IND_ZERO_PESO_E_VOLUME"
	echo ""
	cat /tmp/partenze_zeropesovolume.txt | sed -e 's/IND-ZERO-PESO-E-VOLUME://g'
	/usr/bin/mailx -r "Peso e Volume a 0 <amministrazione@glslatina.it>" -s "Partenze: $IND_ZERO_PESO_E_VOLUME Peso e Volume a 0 $DATE" $FORZATIEMAIL < /tmp/partenze_zeropesovolume.txt
	echo ""
fi

# Eseguilo solo dopo le 20
ADESSO=`date +%H` 
if(test "$ADESSO" -ge 20); then 

if(test "$IND_PESANTI_SENZA_VOLUME_O_REALE" -gt "0"); then
	echo Senza Volume con Peso Reale oltre 30Kg IND-PESANTI-SENZA-VOLUME-O-REALE: "$IND_PESANTI_SENZA_VOLUME_O_REALE"
	echo ""
	cat /tmp/partenze_pesantinovolume.txt | sed -e 's/IND-PESANTI-SENZA-VOLUME-O-REALE://g'
	/usr/bin/mailx -r "Pesanti Senza Volume <amministrazione@glslatina.it>" -s "Partenze: $IND_PESANTI_SENZA_VOLUME_O_REALE Pesanti >30kg Senza Volume  $DATE" $FORZATIEMAIL < /tmp/partenze_pesantinovolume.txt
	/usr/bin/mailx -r "Pesanti Senza Volume <amministrazione@glslatina.it>" -s "Partenze: $IND_PESANTI_SENZA_VOLUME_O_REALE Pesanti >30kg Senza Volume  $DATE" magazzino@glslatina.it < /tmp/partenze_pesantinovolume.txt
	echo ""
fi

# fine check solo dopo le 20
fi

#if(test "$IND_VIRGOLA" -gt "0"); then
#	echo Indirizzi con via senza virgola prima del civico IND-VIRGOLA: "$IND_VIRGOLA"
#	echo ""
#	cat /tmp/partenze_virgola.txt | sed -e 's/IND-VIRGOLA://g'
#	/usr/bin/mailx -r "Indirizzi Senza Virgola <amministrazione@glslatina.it>" -s "Partenze: $IND_VIRGOLA Indirizzi senza Virgola $DATE" $FORZATIEMAIL < /tmp/partenze_virgola.txt
#
#	echo ""
#fi
if(test "$IND_NUMERO" -gt "0"); then
	echo Indirizzi senza numero civico IND-NUMERO: "$IND_NUMERO"
	echo ""
	cat /tmp/partenze_numerocivico.txt | sed -e 's/IND-NUMERO://g'
	cat /tmp/partenze_numerocivico.txt | grep -i vic > /tmp/partenze_numerocivico_vic.txt
	cat /tmp/partenze_numerocivico.txt | grep -iv vic > /tmp/partenze_numerocivico_novic.txt
	/usr/bin/mailx -r "Indirizzi Senza Civico <amministrazione@glslatina.it>" -s "Partenze: $IND_NUMERO Indirizzi senza Civico $DATE" $FORZATIEMAIL < /tmp/partenze_numerocivico.txt
	/usr/bin/mailx -r "Indirizzi Senza Civico <amministrazione@glslatina.it>" -s "Partenze: $IND_NUMERO Indirizzi senza Civico $DATE" operativo@glslatina.it < /tmp/partenze_notetelefono_novic.txt
	/usr/bin/mailx -r "Indirizzi Senza Civico <amministrazione@glslatina.it>" -s "Partenze: $IND_NUMERO Indirizzi senza Civico $DATE" vic@glslatina.it < /tmp/partenze_numerocivico_vic.txt
	echo ""
fi
if(test "$NON_WEBLABELING" -gt "0"); then
	echo Bollettazione NON-WEBLABELING: "$NON_WEBLABELING"
	echo ""
	cat /tmp/partenze_weblabeling.txt | sed -e 's/NON-WEBLABELING://g'
	/usr/bin/mailx -r "Non Weblabeling <amministrazione@glslatina.it>" -s "Partenze: $NON_WEBLABELING Mancata WebLabeling $DATE" $FORZATIEMAIL < /tmp/partenze_weblabeling.txt
	echo ""
fi
if(test "$NON_TEL_NOTE" -gt "0"); then
	echo Manca Telefono in campo note NON-TEL-NOTE: "$NON_TEL_NOTE"
	echo ""
	cat /tmp/partenze_notetelefono.txt | sed -e 's/NON-TEL-NOTE://g'
	cat /tmp/partenze_notetelefono.txt | grep -i vic > /tmp/partenze_notetelefono_vic.txt
	cat /tmp/partenze_notetelefono.txt | grep -iv vic > /tmp/partenze_notetelefono_novic.txt
	/usr/bin/mailx -r "NOTE senza Telefono <amministrazione@glslatina.it>" -s "Partenze: $NON_TEL_NOTE NOTE senza Telefono $DATE" $FORZATIEMAIL < /tmp/partenze_notetelefono.txt
	/usr/bin/mailx -r "NOTE senza Telefono <amministrazione@glslatina.it>" -s "Partenze: $NON_TEL_NOTE NOTE senza Telefono $DATE" operativo@glslatina.it < /tmp/partenze_notetelefono_novic.txt
	/usr/bin/mailx -r "NOTE senza Telefono <amministrazione@glslatina.it>" -s "Partenze: $NON_TEL_NOTE NOTE senza Telefono $DATE" vic@glslatina.it < /tmp/partenze_notetelefono_vic.txt
	echo ""
fi
#if(test "$NON_EMAIL_DEST" -gt "0"); then
#	echo Manca Email Destinatario NON-EMAIL-DEST: "$NON_EMAIL_DEST"
#	echo ""
#	cat /tmp/partenze_emaildest.txt | sed -e 's/NON-EMAIL-DEST://g'
#	/usr/bin/mailx -r "No Email Destinatario <amministrazione@glslatina.it>" -s "Partenze: $NON_EMAIL_DEST Senza Email Destinatario $DATE" $FORZATIEMAIL < /tmp/partenze_emaildest.txt
#	echo ""
#fi
#if(test "$NON_EMAIL_MITT" -gt "0"); then
#	echo Manca Email Mittente NON-EMAIL-MITT: "$NON_EMAIL_MITT"
#	echo ""
#	cat /tmp/partenze_emailmitt.txt | sed -e 's/NON-EMAIL-MITT://'g
#	/usr/bin/mailx -r "No Email Mittente <amministrazione@glslatina.it>" -s "Partenze: $NON_EMAIL_MITT Senza Email Mittente $DATE" $FORZATIEMAIL < /tmp/partenze_emailmitt.txt
#	echo ""
#fi
#if(test "$NON_TEL_DEST" -gt "0"); then
#	echo Manca Tel Destinatario NON-TEL-DEST: "$NON_TEL_DEST"
#	echo ""
#	cat /tmp/partenze_teldest.txt
#	/usr/bin/mailx -r "No Telefono Destinatario <amministrazione@glslatina.it>" -s "Partenze: $NON_TEL_DEST Senza Telefono Destinatario $DATE" $FORZATIEMAIL < /tmp/partenze_teldest.txt
#	echo ""
#fi
#if(test "$NON_TEL_MITT" -gt "0"); then
#	echo Manca Tel Mittente NON-TEL-MITT: "$NON_TEL_MITT"
#	echo ""
#	cat /tmp/partenze_telmitt.txt
#	/usr/bin/mailx -r "No Telefono Mittente <amministrazione@glslatina.it>" -s "Partenze: $NON_TEL_MITT Senza Telefono Mittente $DATE" $FORZATIEMAIL < /tmp/partenze_telmitt.txt
#	echo ""
#fi

	echo ""
	echo DETTAGLIO INDICATORI ECONOMICI
	echo ""
#if(test "$IND_LIGHT_OLTRE_3KG" -gt "0"); then
#	echo Peso oltre 3.5KG su Light IND-LIGHT-OLTRE-3KG: "$IND_LIGHT_OLTRE_3KG"
#	echo ""
#	cat /tmp/partenze_lightoltre.txt
#	/usr/bin/mailx -r "Peso più di 3.5kg Light <amministrazione@glslatina.it>" -s "Partenze: $IND_LIGHT_OLTRE_3KG Peso >3.5Kg su Contratto Light  $DATE" $FORZATIEMAIL < /tmp/partenze_lightoltre.txt
#	echo ""
#fi

#if(test "$IND_NO_LIGHT_MENO_3KG" -gt "0"); then
#	echo Peso sotto 3.5Kg su NON_Light IND-NO-LIGHT-MENO-3KG: "$IND_NO_LIGHT_MENO_3KG"
#	echo ""
#	cat /tmp/partenze_lightsotto.txt | sed -e 's/IND-NO-LIGHT-MENO-3KG://g'
#	/usr/bin/mailx -r "Ottimizza contratti con Agevolazione per Fasce <amministrazione@glslatina.it>" -s "Partenze: $IND_NO_LIGHT_MENO_3KG Peso <3.5Kg su Contratto NON-Light  $DATE" amministrazione@glslatina.it < /tmp/partenze_lightsotto.txt
#	echo ""
#fi

if(test "$IND_PESANTI_OVER_90KG" -gt "0"); then
	echo Pesanti sopra 90KG IND-PESANTI-OVER-90KG: "$IND_PESANTI_OVER_90KG"
	echo ""
	cat /tmp/partenze_pesantisopra.txt | sed -e 's/IND-PESANTI-OVER-90KG://g'
	/usr/bin/mailx -r "Pesanti più di 90kg <amministrazione@glslatina.it>" -s "Partenze: $IND_PESANTI_OVER_90KG Pesanti >90Kg  $DATE" $FORZATIEMAIL < /tmp/partenze_pesantisopra.txt
	echo ""
fi

# Volume over 200KG
if(test "$IND_VOLUME_OVER_200KG" -gt "0"); then
	echo Pesanti Volume 200KG IND-VOLUME-OVER-200KG: "$IND_VOLUME_OVER_200KG"
	echo ""
	cat /tmp/partenze_volumesopra.txt | sed -e 's/IND-VOLUME-OVER-200KG://g'
	/usr/bin/mailx -r "Volume più di200kg <amministrazione@glslatina.it>" -s "Partenze: $IND_VOLUME_OVER_200KGVolume >200Kg  $DATE" $FORZATIEMAIL < /tmp/partenze_volumesopra.txt
	echo ""
fi

# Eseguilo solo dopo le 20
ADESSO=`date +%H` 
if(test "$ADESSO" -ge 20); then 
if(test "$IND_BLOCCATO" -gt "0"); then
	echo Clienti Bloccati IND-BLOCCATO: "$IND_BLOCCATO"
	echo ""
	cat /tmp/partenze_bloccati.txt
#	/usr/bin/mailx -r "Bloccati <amministrazione@glslatina.it>" -s "Partenze: $IND_BLOCCATO CLIENTI BLOCCATI $DATE" $FORZATIEMAIL < /tmp/partenze_bloccati.txt
	/usr/bin/mailx -r "Bloccati <amministrazione@glslatina.it>" -s "Partenze: $IND_BLOCCATO CLIENTI BLOCCATI $DATE" amministrazione@glslatina.it < /tmp/partenze_bloccati.txt
	echo ""
fi
fi

if(test "$IND_OTTIMIZZA_VOLUME_STANDARD" -gt "0"); then
	echo Ottimizza Volume IND-OTTIMIZZA-VOLUME-STANDARD: "$IND_OTTIMIZZA_VOLUME_STANDARD"
	echo ""
	cat /tmp/partenze_volumestandard.txt
	echo ""
fi
if(test "$IND_OTTIMIZZA_VOLUME_EXTRA" -gt "0"); then
	echo Ottimizza Volume Extra IND-OTTIMIZZA-VOLUME-EXTRA: "$IND_OTTIMIZZA_VOLUME_EXTRA"
	echo ""
	cat /tmp/partenze_volumeextra.txt
	echo ""
fi
if(test "$IND_MODIFICABILI_PESA_AUTOMATICA" -gt "0"); then
	echo Spedizioni non_light rettificabili Automatica IND-MODIFICABILI-PESA-AUTOMATICA: "$IND_MODIFICABILI_PESA_AUTOMATICA"
	echo ""
	cat /tmp/partenze_modpesaautomatica.txt
	echo ""
fi
if(test "$IND_MODIFICABILI_MANUALMENTE" -gt "0"); then
	echo Spedizioni non_light rettificabili Manualmente IND-MODIFICABILI-MANUALMENTE: "$IND_MODIFICABILI_MANUALMENTE"
	echo ""
	cat /tmp/partenze_modpesamanuale.txt
	echo ""
fi

if(test "$IND_UNO_ZERO" -gt "0"); then
	echo Peso 1 e Volume a 0 IND-UNO-ZERO-PESO-E-VOLUME: "$IND_UNO_ZERO"
	echo ""
	cat /tmp/partenze_unozero.txt | sed -e 's/IND-UNO-ZERO-PESO-E-VOLUME://g'
	cat /tmp/partenze_unozero.txt | sed -e 's/IND-UNO-ZERO-PESO-E-VOLUME://g' > /tmp/partenze_unozero_clean.txt
	/usr/bin/mailx -r "Peso 1 e Volume a 0 <amministrazione@glslatina.it>" -s "Partenze: $IND_UNO_ZERO Peso 1 e Volume a 0 $DATE" $FORZATIEMAIL < /tmp/partenze_unozero_clean.txt
	echo ""
fi

if(test "$IND_UNO_UNO" -gt "0"); then
	echo Peso 1 e Volume a 1 IND-UNO-UNO-PESO-E-VOLUME: "$IND_UNO_UNO"
	echo ""
	cat /tmp/partenze_unouno.txt | sed -e 's/IND-UNO-UNO-PESO-E-VOLUME://g'
	cat /tmp/partenze_unouno.txt | sed -e 's/IND-UNO-UNO-PESO-E-VOLUME://g' > /tmp/partenze_unouno_clean.txt
	/usr/bin/mailx -r "Peso 1 e Volume a 1 <amministrazione@glslatina.it>" -s "Partenze: $IND_UNO_UNO Peso 1 e Volume a 1 $DATE" $FORZATIEMAIL < /tmp/partenze_unouno_clean.txt
	echo ""
fi


exit
