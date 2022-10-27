#!/bin/sh
USERNAME="t99"
PASSWORD=""
SERVER="10.58.73.2"
 
# local directory to pickup *.tar.gz file
FILE="arrivi_oggi.txt"
 
# remote server directory to upload backup
BACKUPDIR="openedge/scripts/tmp"
 
# login to remote server
ftp -n -i $SERVER <<EOF
user $USERNAME $PASSWORD
cd $BACKUPDIR
lcd /tmp
get $FILE
quit
EOF
