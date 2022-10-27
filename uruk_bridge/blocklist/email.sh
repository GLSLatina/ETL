#!/bin/sh
DATE=`date +%D`

# If there are porti assegnati send an email

	if [ -s "/tmp/arrivi_blocklist-ditta.txt"  ]
		then
			DITTACOUNT=`grep -c NSPED /tmp/arrivi_blocklist-ditta.txt`
	fi

	if [ -s "/tmp/arrivi_blocklist-legali.txt"  ]
		then
			LEGALICOUNT=`grep -c NSPED /tmp/arrivi_blocklist-ditta.txt`
	fi

			TOTALCOUNT=`cat /tmp/arrivi_blocklist-ditta.txt /tmp/arrivi_blocklist-legali.txt 2>/dev/null | grep -c NSPED `

	echo "Blacklist Debitori: Analisi ARRIVI $DATE" > /tmp/blacklist_email.txt
	echo "" >> /tmp/blacklist_email.txt
	echo "Sped da Nomi Ditte: $DITTACOUNT" >> /tmp/blacklist_email.txt
	echo "Sped da Legali Rappresentanti: $LEGALICOUNT" >> /tmp/blacklist_email.txt
	echo "" >> /tmp/blacklist_email.txt
	echo "Possibili arrivi di debitori (da controllare, ci possono essere falsi positivi!)" >> /tmp/blacklist_email.txt
	echo "" >> /tmp/blacklist_email.txt
	
	if [ -s "/tmp/arrivi_blocklist-ditta.txt"  ]
		then
			cat /tmp/arrivi_blocklist-ditta.txt >> /tmp/blacklist_email.txt
	fi

	if [ -s "/tmp/arrivi_blocklist-legali.txt"  ]
		then
			cat /tmp/arrivi_blocklist-legali.txt >> /tmp/blacklist_email.txt
	fi

	echo "Consulta sempre la blacklist debitori per avere certezza prima di bloccare un pacco"  >>/tmp/blacklist_email.txt
	echo "Blacklist debitori: https://docs.google.com/spreadsheets/d/1yZ3TW7XQhq7D6QuZldaCL7uQLrse32Tbz2pAR7-iOTY/edit#gid=0" >> /tmp/blacklist_email.txt


	if [ -s /tmp/blacklist_email.txt ]
		then
			/usr/bin/mailx -r "Blacklist Debitori <amministrazione@glslatina.it>" -s  "Blacklist Debitori: Analisi Arrivi $DATE Count: $TOTALCOUNT"  blacklist@glslatina.it < /tmp/blacklist_email.txt
	fi

