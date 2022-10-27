#!/bin/sh
# SCRIPT DI SINCRONIA ARRIVI

# UPLOAD FTP SERVER
UPUSERNAME="fabio"
UPPASSWORD=""
UPSERVER="212.66.104.34"
 
LOG_ARRIVI_DOMANI=/tmp/conatti.log

# local directory to pickup *.tar.gz file
FILE="/tmp/EXPORT/elencocontatti.csv"
DATE=`date +%Y%m%d%H%M%S`
UPFILE="elencocontatti_$DATE.csv"

# Delete previous file 
#rm -f /tmp/$FILE

if (test ! -f "$FILE"); then
	echo Errore: Manca il file eleco contatti da sincronizzare > /tmp/contatti_error_email.txt
	date >> /tmp/contatti_error_email.txt
	ls -alrt /tmp/EXPORT/ >> /tmp/contatti_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Contatti <amministrazione@glslatina.it>" -s  "ERRORE: Problema con file contatti da sincronizzare" fabio.pietrosanti@glslatina.it < /tmp/contatti_error_email.txt
	exit

fi

# login to remote upload server
ftp -v -n -i $UPSERVER >/tmp/contratti_ftp_upload_output.log 2>/tmp/contratti_ftp_upload_error.log <<EOF
user $UPUSERNAME $UPPASSWORD
lcd /tmp
put $FILE $UPFILE
quit
EOF
RESULTUPLOAD=`grep "Transfer complete" /tmp/contratti_ftp_upload_output.log`

# Check that upload worked properly
if (test ! -n "$RESULTUPLOAD"); then
	echo Errore nel upload del file dei contatti da server URK su server Take Away > /tmp/contatti_ftp_upload_error_email.txt
	date >> /tmp/contatti_ftp_upload_error_email.txt
	if (test -f /tmp/contatti_ftp_upload_output.log); then
	cat /tmp/contatti_ftp_upload_output.log >> /tmp/contatti_ftp_upload_error_email.txt
	fi
	if (test -f /tmp/contatti_ftp_upload_error.log); then
	cat /tmp/contatti_ftp_upload_error.log >> /tmp/contatti_ftp_upload_error_email.txt
	fi
	/usr/bin/mailx -r "Errore Sincronizzazione Contatti <amministrazione@glslatina.it>" -s  "ERRORE: Problema in upload contatti da URUK per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/contatti_ftp_upload_error_email.txt
	exit

fi

