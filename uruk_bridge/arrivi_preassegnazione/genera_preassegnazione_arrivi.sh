#!/bin/sh

TODAY=`date +%a`

# Se Venerd� la data di riferimento è lunedì
#
if(test "$TODAY" = "Fri"); then
	DOMANI=`date --date="+3 days"  +%d/%m/%y`
	grep $DOMANI /tmp/arrivi_domani.csv > /tmp/arrivi_preassegnazione.csv
else
	DOMANI=`date --date="next day"  +%d/%m/%y`
	grep $DOMANI /tmp/arrivi_domani.csv > /tmp/arrivi_preassegnazione.csv
fi


#	FILEARRIVI=arrivi_domani.csv
	FILEARRIVI=/tmp/arrivi_preassegnazione.csv
	FILECODICIGIRO=/tmp/arrivi_codici_giri.txt
	COUNTARRIVI=`cat $FILEARRIVI | wc -l`

	# $17 indirizzo destinatario
	# $64 codice autista
	# $29 colli
	# $30 peso


	TOTPESO=`gawk -Fµ 'BEGIN{IGNORECASE=1} ($17 !~ /fermo deposito/)  { print $30 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
	TOTCAASS=`gawk -Fµ 'BEGIN{IGNORECASE=1}  (tolower($49)  ~ /ASS/) && ($17 !~ /fermo deposito/)  { print $32 }'  $FILEARRIVI |  perl -lpe '$c+=$_}{$_=$c'`
	TOTCACONT=`gawk -Fµ 'BEGIN{IGNORECASE=1}  (tolower($49)  ~ /CONT/) && ($17 !~ /fermo deposito/)  { print $32 }'  $FILEARRIVI |  perl -lpe '$c+=$_}{$_=$c'`
#	TOTCOMPET=`gawk -Fµ 'BEGIN{IGNORECASE=1}  ($17 !~ /fermo deposito/)  { print $45 }'  $FILEARRIVI |  perl -lpe '$c+=$_}{$_=$c'`

	echo ""
	echo PREVISIONALE ARRIVI
	echo ""
	echo Data Arrivi: $DOMANI
	echo ""
	echo Spedizioni : $COUNTARRIVI
	echo ""
	echo Peso       : $TOTPESO KG
	echo ""
	echo Contrass   : Contanti: € $TOTCACONT - Assegni:  € $TOTCAASS
#	echo Competenze : € $TOTCOMPET 
	echo ""
	echo ""
	echo ==== DETTAGLIO GIRI ====
	echo ""


	rm -f  $FILECODICIGIRO

	# Estrai codici giri e mettili in un file temporaneo
		awk -Fµ '{ print $64 }' $FILEARRIVI  | tr  '[:lower:]' '[:upper:]'  | egrep '[A-Z]' | sort -n |  uniq > $FILECODICIGIRO

	for codicegiro in `cat $FILECODICIGIRO`; 
	 do

		SPED=` gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $1,$2,$3,$64 }' $FILEARRIVI  | wc -l`
		COLLI=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $29 }' $FILEARRIVI  | paste -s -d+ - | bc`
		PESO=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1} (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $30 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
		VIE=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $17 }' $FILEARRIVI   | sed -e 's/,.*$//' -e 's/"$//'| tr '[:upper:]' '[:lower:]'  | sort -rn | uniq | wc -l`
		STOP=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $17 }' $FILEARRIVI   | tr '[:upper:]' '[:lower:]'  | sort -rn | uniq | wc -l`
		CACONT=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1} (tolower($49)  ~ /CONT/) && (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $32 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
		CAASS=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1} (tolower($49)  ~ /ASS/) && (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $32 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
		COMPET=`gawk -v codicegiro="$codicegiro" -Fµ 'BEGIN{IGNORECASE=1} (tolower($64)  ~ /'$codicegiro'/) && ($17 !~ /fermo deposito/)  { print $45 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`

		echo  "GIRO: $codicegiro " | sed -e 's/"//g'
#		echo  "(€ $COMPET)"
		echo ""
		echo  "SPED: $SPED - STOP: $STOP - VIE: $VIE"
		echo  "PESO: $PESO kg ($COLLI colli)"
		echo  "cash: € $CACONT - assegni: € $CAASS"
	#	echo  "STOP : $STOP - VIE: $VIE"
		echo ""
		echo ""



	 done

		echo GIRO "??: "
	#gawk  -Fµ 'BEGIN{IGNORECASE=1}  ($64  ~ /\?\?/) && ($17 !~ /fermo deposito/)  { print $1,$2,$3,$64 }' $FILEARRIVI  | wc -l
	SPED=` gawk  -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /\?\?/) && ($17 !~ /fermo deposito/)  { print $1,$2,$3,$64 }' $FILEARRIVI  | wc -l`
	COLLI=`gawk  -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /\?\?/) && ($17 !~ /fermo deposito/)  { print $29 }' $FILEARRIVI  | paste -s -d+ - | bc`
	PESO=`gawk  -Fµ 'BEGIN{IGNORECASE=1} (tolower($64)  ~ /\?\?/) && ($17 !~ /fermo deposito/)  { print $30 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
	echo  "SPED : $SPED ($COLLI colli)"
	echo  "PESO : $PESO kg "
	echo ""

	echo GIRO "\"\": "
	#gawk  -Fµ 'BEGIN{IGNORECASE=1}  ($64 ~ /\"\"/) && ($17 !~ /fermo deposito/)  { print $1,$2,$3,$64 }' $FILEARRIVI  | wc -l
	SPED=` gawk -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /\"\"/) && ($17 !~ /fermo deposito/)  { print $1,$2,$3,$64 }' $FILEARRIVI  | wc -l`
	COLLI=`gawk -Fµ 'BEGIN{IGNORECASE=1}  (tolower($64)  ~ /\"\"/) && ($17 !~ /fermo deposito/)  { print $29 }' $FILEARRIVI  | paste -s -d+ - | bc`
	PESO=`gawk  -Fµ 'BEGIN{IGNORECASE=1} (tolower($64)  ~ /\"\"/) && ($17 !~ /fermo deposito/)  { print $30 }'  $FILEARRIVI | sed -e 's/^\./0\./' | perl -lpe '$c+=$_}{$_=$c'`
	echo  "SPED : $SPED ($COLLI colli)"
	echo  "PESO : $PESO kg "
	echo ""
