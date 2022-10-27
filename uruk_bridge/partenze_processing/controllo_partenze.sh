 #!/bin/sh

MSGFILE=/tmp/partenze_analisi.txt
FORZATIEMAIL=controllopartenze@glslatina.it
DATE=`date`

# PORTO FRANCO
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 1  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 1 > $MSGFILE

# Rilevanti pre-partenze
/usr/bin/mailx -r "Sintesi Indicatori Partenze <amministrazione@glslatina.it>" -s "Partenze: Sintesi Indicatori $DATE" $FORZATIEMAIL < /tmp/partenze_sintesi.txt 
/usr/bin/mailx -r "Indirizzi Forzati <amministrazione@glslatina.it>" -s "Partenze: Indirizzi Forzati $DATE" $FORZATIEMAIL < /tmp/partenze_forzati.txt 
/usr/bin/mailx -r "Peso e Volume a 0 <amministrazione@glslatina.it>" -s "Partenze: Peso e Volume a 0 $DATE" $FORZATIEMAIL < /tmp/partenze_zeropesovolume.txt 
/usr/bin/mailx -r "Pesanti Senza Volume <amministrazione@glslatina.it>" -s "Partenze: Pesanti >30kg Senza Volume  $DATE" $FORZATIEMAIL < /tmp/partenze_pesantinovolume.txt 
#/usr/bin/mailx -r "Peso più di 3.5kg Light <amministrazione@glslatina.it>" -s "Partenze: Peso >3.5Kg su Contratto Light  $DATE" $FORZATIEMAIL < /tmp/partenze_lightoltre.txt 
#/usr/bin/mailx -r "Peso meno di 3.5kg Non-Light <amministrazione@glslatina.it>" -s "Partenze: Peso <3.5Kg su Contratto NON-Light  $DATE" $FORZATIEMAIL < /tmp/partenze_lightsotto.txt 
/usr/bin/mailx -r "Pesanti più di 90kg <amministrazione@glslatina.it>" -s "Partenze: Pesanti >90Kg  $DATE" $FORZATIEMAIL < /tmp/partenze_pesantisopra.txt 
/usr/bin/mailx -r "Bloccati <amministrazione@glslatina.it>" -s "Partenze: CLIENTI BLOCCATI $DATE" $FORZATIEMAIL < /tmp/partenze_bloccati.txt 


# Rilevanti post-partenze

/usr/bin/mailx -r "Sintesi Indicatori Partenze <amministrazione@glslatina.it>" -s "Partenze: Sintesi Indicatori $DATE" $FORZATIEMAIL < /tmp/partenze_sintesi.txt 
/usr/bin/mailx -r "Non Weblabeling <amministrazione@glslatina.it>" -s "Partenze: Mancata WebLabeling $DATE" $FORZATIEMAIL < /tmp/partenze_weblabeling.txt 
/usr/bin/mailx -r "NOTE senza Telefono <amministrazione@glslatina.it>" -s "Partenze: NOTE senza Telefono $DATE" $FORZATIEMAIL < /tmp/partenze_notetelefono.txt 
/usr/bin/mailx -r "Indirizzi Senza Virgola <amministrazione@glslatina.it>" -s "Partenze: Indirizzi senza Virgola $DATE" $FORZATIEMAIL < /tmp/partenze_virgola.txt 
/usr/bin/mailx -r "Indirizzi Senza Numero Civico <amministrazione@glslatina.it>" -s "Partenze: Indirizzi senza Numero Civico $DATE" $FORZATIEMAIL < /tmp/partenze_numerocivico.txt 
/usr/bin/mailx -r "No Email Destinatario <amministrazione@glslatina.it>" -s "Partenze: Nessun Email Destinatario $DATE" $FORZATIEMAIL < /tmp/partenze_emaildest.txt 
/usr/bin/mailx -r "No Email Mittente <amministrazione@glslatina.it>" -s "Partenze: Nessun Email Mittente $DATE" $FORZATIEMAIL < /tmp/partenze_emailmitt.txt 
/usr/bin/mailx -r "No Telefono Destinatario <amministrazione@glslatina.it>" -s "Partenze: Nessun Telefono Destinatario $DATE" $FORZATIEMAIL < /tmp/partenze_teldest.txt 
/usr/bin/mailx -r "No Telefono Mittente <amministrazione@glslatina.it>" -s "Partenze: Nessun Telefono Mittente $DATE" $FORZATIEMAIL < /tmp/partenze_telmitt.txt 

# Invia Email
#  /usr/bin/mailx -r "Partenze Porto Franco <amministrazione@glslatina.it>" -s "Indirizzi Forzati Partenze Porto Franco $DATE" $FORZATIEMAIL < /tmp/partenze_forzati.txt 

#
#/usr/bin/mailx -r "Partenze Porto Franco <amministrazione@glslatina.it>" -s "Report Partenze Porto Franco " fabio.pietrosanti@glslatina.it < /tmp/partenze_analisi.txt

#	 controllopartenze@glslatina.it < $MSGFILE 
exit

# PORTO ASSEGNATO
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 2  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 2 > /tmp/partenze_analisi.txt
# Invia Email
/usr/bin/mailx -r "Partenze Porto Assegnato <amministrazione@glslatina.it>" -s "Controllo Partenze Porto Assegnato" \
	-a  /tmp/partenze_forzati.txt -a  /tmp/partenze_zeropesovolume.txt  -a  /tmp/partenze_pesantinovolume.txt \
        -a  /tmp/partenze_virgola.txt -a  /tmp/partenze_numerocivico.txt -a  /tmp/partenze_weblabeling.txt \
        -a  /tmp/partenze_notetelefono.txt -a  /tmp/partenze_emaildest.txt -a  /tmp/partenze_emailmitt.txt \
        -a  /tmp/partenze_lightoltre.txt -a  /tmp/partenze_lightsotto.txt -a  /tmp/partenze_pesantisopra.txt \
        -a  /tmp/partenze_bloccati.txt -a  /tmp/partenze_volumestandard.txt -a  /tmp/partenze_volumeextra.txt \
        -a  /tmp/partenze_modpesaautomatica.txt -a  /tmp/partenze_modpesamanuale.txt \
	 controllopartenze@glslatina.it < $MSGFILE 

# INDIRETTI
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 3  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 3 > /tmp/partenze_analisi.txt
# Invia Email
/usr/bin/mailx -r "Partenze Indiretti <amministrazione@glslatina.it>" -s "Controllo Partenze Indiretti" \
	-a  /tmp/partenze_forzati.txt -a  /tmp/partenze_zeropesovolume.txt  -a  /tmp/partenze_pesantinovolume.txt \
        -a  /tmp/partenze_virgola.txt -a  /tmp/partenze_numerocivico.txt -a  /tmp/partenze_weblabeling.txt \
        -a  /tmp/partenze_notetelefono.txt -a  /tmp/partenze_emaildest.txt -a  /tmp/partenze_emailmitt.txt \
        -a  /tmp/partenze_lightoltre.txt -a  /tmp/partenze_lightsotto.txt -a  /tmp/partenze_pesantisopra.txt \
        -a  /tmp/partenze_bloccati.txt -a  /tmp/partenze_volumestandard.txt -a  /tmp/partenze_volumeextra.txt \
        -a  /tmp/partenze_modpesaautomatica.txt -a  /tmp/partenze_modpesamanuale.txt \
	 controllopartenze@glslatina.it < $MSGFILE 


# FRANCO CORRISPETTIVO
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 9  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 9 > /tmp/partenze_analisi.txt
# Invia Email
/usr/bin/mailx -r "Partenze Franco Corrispettivo <amministrazione@glslatina.it>" -s "Controllo Partenze Franco Corrispettivo" \
	-a  /tmp/partenze_forzati.txt -a  /tmp/partenze_zeropesovolume.txt  -a  /tmp/partenze_pesantinovolume.txt \
        -a  /tmp/partenze_virgola.txt -a  /tmp/partenze_numerocivico.txt -a  /tmp/partenze_weblabeling.txt \
        -a  /tmp/partenze_notetelefono.txt -a  /tmp/partenze_emaildest.txt -a  /tmp/partenze_emailmitt.txt \
        -a  /tmp/partenze_lightoltre.txt -a  /tmp/partenze_lightsotto.txt -a  /tmp/partenze_pesantisopra.txt \
        -a  /tmp/partenze_bloccati.txt -a  /tmp/partenze_volumestandard.txt -a  /tmp/partenze_volumeextra.txt \
        -a  /tmp/partenze_modpesaautomatica.txt -a  /tmp/partenze_modpesamanuale.txt \
	 controllopartenze@glslatina.it < $MSGFILE 


# ASSEGNATO CORRISPETTIVO
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 10  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 10 > /tmp/partenze_analisi.txt
# Invia Email
/usr/bin/mailx -r "Partenze Assegnato Corrispettivo <amministrazione@glslatina.it>" -s "Controllo Partenze Assegnato Corrispettivo" \
	-a  /tmp/partenze_forzati.txt -a  /tmp/partenze_zeropesovolume.txt  -a  /tmp/partenze_pesantinovolume.txt \
        -a  /tmp/partenze_virgola.txt -a  /tmp/partenze_numerocivico.txt -a  /tmp/partenze_weblabeling.txt \
        -a  /tmp/partenze_notetelefono.txt -a  /tmp/partenze_emaildest.txt -a  /tmp/partenze_emailmitt.txt \
        -a  /tmp/partenze_lightoltre.txt -a  /tmp/partenze_lightsotto.txt -a  /tmp/partenze_pesantisopra.txt \
        -a  /tmp/partenze_bloccati.txt -a  /tmp/partenze_volumestandard.txt -a  /tmp/partenze_volumeextra.txt \
        -a  /tmp/partenze_modpesaautomatica.txt -a  /tmp/partenze_modpesamanuale.txt \
	 controllopartenze@glslatina.it < $MSGFILE 


# CONTO SERVIZIO
# Analizza il file delle partenze porto franco per estrarre anomalie
./analizza_partenze.sh 13  > /tmp/partenze_preanalisi.txt
# Estrai indicatori quantitativi per ogni anomalia e preparara email del report
./estrai_analisi_partenze.sh 13 > /tmp/partenze_analisi.txt
# Invia Email
/usr/bin/mailx -r "Partenze Conto Servizio <amministrazione@glslatina.it>" -s "Controllo Partenze Contro Servizio" \
	-a  /tmp/partenze_forzati.txt -a  /tmp/partenze_zeropesovolume.txt  -a  /tmp/partenze_pesantinovolume.txt \
        -a  /tmp/partenze_virgola.txt -a  /tmp/partenze_numerocivico.txt -a  /tmp/partenze_weblabeling.txt \
        -a  /tmp/partenze_notetelefono.txt -a  /tmp/partenze_emaildest.txt -a  /tmp/partenze_emailmitt.txt \
        -a  /tmp/partenze_lightoltre.txt -a  /tmp/partenze_lightsotto.txt -a  /tmp/partenze_pesantisopra.txt \
        -a  /tmp/partenze_bloccati.txt -a  /tmp/partenze_volumestandard.txt -a  /tmp/partenze_volumeextra.txt \
        -a  /tmp/partenze_modpesaautomatica.txt -a  /tmp/partenze_modpesamanuale.txt \
	 controllopartenze@glslatina.it < $MSGFILE 
