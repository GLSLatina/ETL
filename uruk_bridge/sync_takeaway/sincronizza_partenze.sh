#!/bin/sh
# SCRIPT DI SINCRONIA PARTENZE

# DOWNLOAD FTP SERVER
USERNAME="t99"
PASSWORD=""
SERVER="10.58.73.2"

# UPLOAD FTP SERVER
UPUSERNAME="fabio"
UPPASSWORD=""
UPSERVER="212.66.104.34"
 
LOG_PARTENZE_DOMANI=/tmp/partenze_oggi.log

# local directory to pickup *.tar.gz file
DATE=`date +%Y%m%d%H%M%S`

FILEPARTENZE="partenze_oggi.csv"
UPFILEPARTENZE="partenze_oggi_$DATE.txt"

# Delete previous file 
rm -f /tmp/$FILEPARTENZE

# remote server directory to upload backup
BACKUPDIR="openedge/scripts/tmp"
 
# login to remote download server
ftp -n -i $SERVER >/tmp/partenze_oggi_ftp_download_output.log 2>/tmp/partenze_oggi_ftp_download_error.log <<EOF
user $USERNAME $PASSWORD
cd $BACKUPDIR
lcd /tmp
get $FILEPARTENZE
quit
EOF

if (test ! -f "/tmp/$FILEPARTENZE"); then
	echo Errore nel download delle partenze di oggi da GLS SI per upload su server Take Away > /tmp/partenze_oggi_ftp_download_error_email.txt
	date >> /tmp/partenze_oggi_ftp_download_error_email.txt
	cat /tmp/partenze_oggi_ftp_download_output.log >> /tmp/partenze_oggi_ftp_download_error_email.txt
	cat /tmp/partenze_oggi_ftp_download_error.log >> /tmp/partenze_oggi_ftp_download_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>" -s  "ERRORE: Problema in download da GLS SI con account t99 eseguito da server URUK, per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/partenze_oggi_ftp_download_error_email.txt
	exit

fi

# login to remote upload server
ftp -v -n -i $UPSERVER >/tmp/partenze_oggi_ftp_upload_output.log 2>/tmp/partenze_oggi_ftp_upload_error.log <<EOF
user $UPUSERNAME $UPPASSWORD
lcd /tmp
put $FILEPARTENZE $UPFILEPARTENZE
quit
EOF
RESULTUPLOAD=`grep "Transfer complete" /tmp/partenze_oggi_ftp_upload_output.log`

# Check that upload worked properly
if (test ! -n "$RESULTUPLOAD"); then
	echo Errore nel upload degli partenze di oggi da server URK su server Take Away > /tmp/partenze_oggi_ftp_upload_error_email.txt
	date >> /tmp/partenze_oggi_ftp_upload_error_email.txt
	cat /tmp/partenze_oggi_ftp_upload_output.log >> /tmp/partenze_oggi_ftp_upload_error_email.txt
	cat /tmp/partenze_oggi_ftp_upload_error.log >> /tmp/partenze_oggi_ftp_upload_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>" -s  "ERRORE: Problema in upload da URUK per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/partenze_oggi_ftp_upload_error_email.txt
	exit

fi

DATACONTROLLO=`date +%d-%m-%Y\ %H:%M`
QUANTIPARTENZE=`wc -l /tmp/$FILEPARTENZE`
echo $DATACONTROLLO $QUANTIPARTENZE >> $LOG_PARTENZE_DOMANI
