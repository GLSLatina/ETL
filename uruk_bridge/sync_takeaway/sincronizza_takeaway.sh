#!/bin/sh
# SCRIPT DI SINCRONIA ARRIVI

# DOWNLOAD FTP SERVER
USERNAME="t99"
PASSWORD=""
SERVER="10.58.73.2"

# UPLOAD FTP SERVER
UPUSERNAME="fabio"
UPPASSWORD=""
UPSERVER="212.66.104.34"
 
LOG_ARRIVI_DOMANI=/tmp/arrivi_domani.log

# local directory to pickup *.tar.gz file
FILE="arrivi_domani.csv"
DATE=`date +%Y%m%d%H%M%S`
UPFILE="arrivi_domani_$DATE.csv"

FILEPDC="pdc_oggi.txt.gz"
UPFILEPDC="pdc_oggi_$DATE.txt.gz"

FILEAUTISTI="autisti_oggi.txt"
UPFILEAUTISTI="autisti_oggi_$DATE.txt"

# Delete previous file 
rm -f /tmp/$FILE
rm -f /tmp/$FILEPDC
rm -f /tmp/$FILEAUTISTI

# remote server directory to upload backup
BACKUPDIR="openedge/scripts/tmp"
 
# login to remote download server
ftp -n -i $SERVER >/tmp/arrivi_domani_ftp_download_output.log 2>/tmp/arrivi_domani_ftp_download_error.log <<EOF
user $USERNAME $PASSWORD
cd $BACKUPDIR
lcd /tmp
get $FILE
get $FILEPDC
get $FILEAUTISTI
quit
EOF

if (test ! -f "/tmp/$FILE"); then
	echo Errore nel download degli arrivi di domani da GLS SI per upload su server Take Away > /tmp/arrivi_domani_ftp_download_error_email.txt
	date >> /tmp/arrivi_domani_ftp_download_error_email.txt
	cat /tmp/arrivi_domani_ftp_download_output.log >> /tmp/arrivi_domani_ftp_download_error_email.txt
	cat /tmp/arrivi_domani_ftp_download_error.log >> /tmp/arrivi_domani_ftp_download_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>" -s  "ERRORE: Problema in download da GLS SI con account t99 eseguito da server URUK, per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/arrivi_domani_ftp_download_error_email.txt
	exit

fi

if (test ! -f "/tmp/$FILEPDC"); then
	echo Errore nel download delle PDC da GLS SI per upload su server Take Away > /tmp/arrivi_pdc_ftp_download_error_email.txt
	date >> /tmp/arrivi_pdc_ftp_download_error_email.txt
	cat /tmp/arrivi_domani_ftp_download_output.log  >> /tmp/arrivi_pdc_ftp_download_error_email.txt
	cat /tmp/arrivi_domani_ftp_download_error.log  >> /tmp/arrivi_pdc_ftp_download_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>" -s  "ERRORE: Problema in download PDC da GLS SI con account t99 eseguito da server URUK, per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/arrivi_pdc_ftp_download_error_email.txt
	exit

fi

# login to remote upload server
ftp -v -n -i $UPSERVER >/tmp/arrivi_domani_ftp_upload_output.log 2>/tmp/arrivi_domani_ftp_upload_error.log <<EOF
user $UPUSERNAME $UPPASSWORD
lcd /tmp
put $FILE $UPFILE
put $FILEPDC $UPFILEPDC
put $FILEAUTISTI $UPFILEAUTISTI
quit
EOF
RESULTUPLOAD=`grep "Transfer complete" /tmp/arrivi_domani_ftp_upload_output.log`

# Check that upload worked properly
if (test ! -n "$RESULTUPLOAD"); then
	echo Errore nel upload degli arrivi di domani da server URK su server Take Away > /tmp/arrivi_domani_ftp_upload_error_email.txt
	date >> /tmp/arrivi_domani_ftp_upload_error_email.txt
	cat /tmp/arrivi_domani_ftp_upload_output.log >> /tmp/arrivi_domani_ftp_upload_error_email.txt
	cat /tmp/arrivi_domani_ftp_upload_error.log >> /tmp/arrivi_domani_ftp_upload_error_email.txt
	/usr/bin/mailx -r "Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>" -s  "ERRORE: Problema in upload da URUK per upload su Take Away" fabio.pietrosanti@glslatina.it < /tmp/arrivi_domani_ftp_upload_error_email.txt
	exit

fi

DATACONTROLLO=`date +%d-%m-%Y\ %H:%M`
QUANTIARRIVI=`wc -l /tmp/$FILE`
echo $DATACONTROLLO $QUANTIARRIVI >> $LOG_ARRIVI_DOMANI
