#!/bin/sh
# SCRIPT DI SINCRONIA ARRIVI

# DOWNLOAD FTP SERVER
USERNAME="t99"
PASSWORD=""
SERVER="10.58.73.2"

# UPLOAD FTP SERVER
#UPUSERNAME="fabio"
#UPPASSWORD=""
#UPSERVER="glslatina.panservice.net"
 
LOG_PARTENZE_OGGI=/tmp/partenze_4_mesi.log

# local directory to pickup *.tar.gz file
FILE="partenze_4_mesi.csv"
DATE=`date +%Y%m%d%H%M%S`
#UPFILE="arrivi_domani_$DATE.csv"

# Delete previous file 
rm -f /tmp/$FILE

# remote server directory to upload backup
BACKUPDIR="openedge/scripts/tmp"
 
# login to remote download server
ftp -n -i $SERVER >/tmp/partenze_4_mesi_ftp_download_output.log 2>/tmp/partenze_4_mesi_ftp_download_error.log <<EOF
user $USERNAME $PASSWORD
cd $BACKUPDIR
lcd /tmp
get $FILE
quit
EOF

if (test ! -f "/tmp/$FILE"); then
	echo Errore nel download delle partenze di 4_mesi da GLS SI per processamento > /tmp/partenze_4_mesi_ftp_download_error_email.txt
	date >> /tmp/partenze_4_mesi_ftp_download_error_email.txt
	cat /tmp/partenze_4_mesi_ftp_download_output.log >> /tmp/partenze_4_mesi_ftp_download_error_email.txt
	cat /tmp/partenze_4_mesi_ftp_download_error.log >> /tmp/partenze_4_mesi_ftp_download_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Partenze <amministrazione@glslatina.it>" -s  "ERRORE: Problema in download Partenze 4 Mesi da GLS SI con account t99 eseguito da server URUK" fabio.pietrosanti@glslatina.it < /tmp/partenze_4_mesi_ftp_download_error_email.txt
	exit

fi

DATACONTROLLO=`date +%d-%m-%Y\ %H:%M`
QUANTEPARTENZE=`wc -l /tmp/$FILE`
echo $DATACONTROLLO $QUANTEPARTENZE >> $LOG_PARTENZE_OGGI
