#!/bin/sh
DATE=`date +%D`

# If there are porti assegnati send an email


	TOTALCOUNT=`cat /tmp/arrivi_borghi_localita_latina.txt 2>/dev/null | grep -c NSPED `

	echo "Spedizioni con Località Latina ma Vie Borghi: $DATE" > /tmp/borghi_email.txt
	echo "" >> /tmp/borghi_email.txt
	echo "Numero Spedizioni: $TOTALCOUNT" >> /tmp/borghi_email.txt
	echo "" >> /tmp/borghi_email.txt
	echo "Procedere con addebito arrivi Borgo/Località di riferimento 0,52 euro" >> /tmp/borghi_email.txt
	echo "" >> /tmp/borghi_email.txt
	
	if [ -s "/tmp/arrivi_borghi_localita_latina.txt"  ]
		then
			cat /tmp/arrivi_borghi_localita_latina.txt >> /tmp/borghi_email.txt
	fi

	echo "Verifica sempre se è addebitabile, e se una via crea un falso positivo, cancellala dal google spreadsheet riportato in seguito" >>/tmp/borghi_email.txt
	echo "Vie Borghi e Località: https://docs.google.com/spreadsheets/d/11X9gbFYu-PKFMKYROrzpJ2T8gegGU7NqvnuktNR3Cvo/edit?usp=sharing" >> /tmp/borghi_email.txt


	if [ -s /tmp/borghi_email.txt ]
		then
			/usr/bin/mailx -r "Addebiti Borghi <amministrazione@glslatina.it>" -s  "Addebiti Borghi: Analisi Arrivi $DATE Count: $TOTALCOUNT"  addebitiborghi@glslatina.it < /tmp/borghi_email.txt
	fi

