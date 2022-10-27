#!/bin/sh
# SCRIPT DI SINCRONIA ARRIVI

# UPLOAD FTP SERVER
UPUSERNAME="fabio"
UPPASSWORD=""
UPSERVER="212.66.104.34"
 
LOG_ARRIVI_DOMANI=/tmp/contratti.log

# local directory to pickup *.tar.gz file
FILE="/tmp/EXPORT/elencocontratti.csv"
DATE=`date +%Y%m%d%H%M%S`
UPFILE="elencocontratti_$DATE.csv"

# Delete previous file 
#rm -f /tmp/$FILE

if (test ! -f "$FILE"); then
	echo Errore: Manca il file eleco contratti da sincronizzare > /tmp/contratti_error_email.txt
	date >> /tmp/contratti_error_email.txt
	ls -alrt /tmp/EXPORT/ >> /tmp/contratti_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Contratti <amministrazione@glslatina.it>" -s  "ERRORE: Problema con file contratti da sincronizzare" fabio.pietrosanti@glslatina.it < /tmp/contratti_error_email.txt
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
	echo Errore nel upload del file dei contratti da server URK su server Take Away > /tmp/contratti_ftp_upload_error_email.txt
	date >> /tmp/contratti_ftp_upload_error_email.txt
	cat /tmp/contratti_ftp_upload_output.log >> /tmp/contratti_ftp_upload_error_email.txt
	cat /tmp/contratti_ftp_upload_error.log >> /tmp/contratti_ftp_upload_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Contratti <amministrazione@glslatina.it>" -s  "ERRORE: Problema in upload contratti da URUK per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/contratti_ftp_upload_error_email.txt
	exit

fi

