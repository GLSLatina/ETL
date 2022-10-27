#!/bin/bash

## Script per sincronizzare lo stato giacenze dalla intranet a takeaway
SCRIPT_DIR=/root/svincolo_giacenze_test
cd $SCRIPT_DIR || exit

## vars per la intranet
INTRANET_USER=latina
## la pass cambia ogni 3 - 4 mesi
INTRANET_PWD=""
DATA_INIZIO=$(date --date="14 days ago"  +%d/%m/%Y)
DATA_FINE=$(date +%d/%m/%Y)
# echo "DATA_INIZIO : $DATA_INIZIO"
# echo "DATA_FINE : $DATA_FINE"
## tipi di giacenza e filename associato
declare -a tipo_giacenza=( 
    "Dasvincolare" 
    "Svincolate"  
)

#declare -a tipo_giacenza=( 
#    "Dasvincolare" 
#)

## al momento unico cliente da aggiornare
MITTENTE=sdoganato.com
FILE_SUFFIX="_sdoganato_$(date +%Y%m%d%H%M%S).csv"


## download files dello stato delle giacenze dalla intranet
get_intranet_file() {
    
    if [ -z "$1" ]; then
        echo "err, manca il tipo di giacenza, skipping"
        return
    fi

    TIPO=$1
    OUT_FILE="$1$FILE_SUFFIX"
    echo "tipo : $TIPO"
    echo "out file : $OUT_FILE"
    
    STATUS=$(curl -s -w '%{http_code}' --ntlm -u $INTRANET_USER:$INTRANET_PWD \
    "https://intranet.gls-italy.com/PHPApps/Gestione_Giacenze/UtenteCreaReportTXT.php?sede=LT&tipo_giacenze=$TIPO&mittente_pagante=$MITTENTE&dataPartenza=&dataGiacenza=$DATA_INIZIO&adataGiacenza=$DATA_FINE&causaleGiacenza=&spedizione=&ordine=DataGiacenza" \
    --output "$OUT_FILE"
    )

    if [ "$STATUS" -eq 200 ]; then
        echo "Download success"
    else
        echo "Error, status code : $STATUS"
        SENDER_EMAIL="Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>"
        RECIPIENT_EMAILS="marco.marafini@glslatina.it"
        #CC="marco.marafini@glslatina.it"
        CC="fabio.pietrosanti@glslatina.it"
        echo "sending the email to : $RECIPIENT_EMAILS"
        SUBJECT="ERRORE: download da Intranet, file $TIPO"
        BODY_MSG="
Errore nel download dello stato giacenze di oggi da GLS Intranet su server URUK.

$(date)
tipo giacenze : $1

status code : $STATUS 

req:
https://intranet.gls-italy.com/PHPApps/Gestione_Giacenze/UtenteCreaReportTXT.php?sede=LT&tipo_giacenze=$TIPO&mittente_pagante=$MITTENTE&dataPartenza=&dataGiacenza=$DATA_INIZIO&adataGiacenza=$DATA_FINE&causaleGiacenza=&spedizione=&ordine=DataGiacenza 

"
#resp :
#$(< "$OUT_FILE")
#"

        echo "$BODY_MSG" | /usr/bin/mailx -r "$SENDER_EMAIL" -s "$SUBJECT" -c "$CC" "$RECIPIENT_EMAILS"
        #echo "$BODY_MSG" | EMAIL=$SENDER_EMAIL mutt -s "$SUBJECT" -c "$CC" -- "$RECIPIENT_EMAILS"
        ## remove response file
        rm -f "$OUT_FILE"
    fi
}

## invia i dati su ftp a server takeaway
send_via_ftp() {
    
    if [ -z "$1" ]; then
        echo "err, manca il tipo di giacenza, skipping"
        return
    fi

    if ! [ -f "$1$FILE_SUFFIX" ]; then
        echo "err, file not found, skipping"
        return
    fi

    FILE_TO_SEND="$1$FILE_SUFFIX"
    ## old, test
    #FILE_TO_SEND="fake_no_file"
    #UPSERVER='212.66.104.34'
    #UPUSERNAME='marco'
    #UPPASSWORD=""
    #DEST_PATH='/home/marco'

    # UPLOAD FTP SERVER
    UPUSERNAME="fabio"
    UPPASSWORD=""
    UPSERVER="212.66.104.34"
    echo "file to send : $FILE_TO_SEND"

# login to remote upload server
ftp -p -v -n -i $UPSERVER >log 2>err.log <<EOF
user $UPUSERNAME $UPPASSWORD 
lcd 
put $FILE_TO_SEND 
bye 
EOF

    RESULTUPLOAD=$(grep "Transfer complete" log)
    # Check that upload worked properly
    if test ! -n "$RESULTUPLOAD"; then
        echo "Error on send"
        SENDER_EMAIL="Errore Sincronizzazione Takeaway <amministrazione@glslatina.it>"
        RECIPIENT_EMAILS="marco.marafini@glslatina.it"
        #CC="marco.marafini@glslatina.it"
        CC="fabio.pietrosanti@glslatina.it"
        echo "sending the email to : $RECIPIENT_EMAILS"
        SUBJECT="ERRORE: upload stato giacenze da URUK su Takeaway, file $FILE_TO_SEND"
        BODY_MSG="
Errore nell'upload dello stato giacenze di oggi da server URUK su server Takeaway.
$(date)
tipo giacenze : $1
file : $FILE_TO_SEND

log:
$(<log)

err.log :
$(<err.log)
"
        echo "$BODY_MSG"
        echo "$BODY_MSG" | /usr/bin/mailx -r "$SENDER_EMAIL" -s "$SUBJECT" -c "$CC" "$RECIPIENT_EMAILS"
        #echo "$BODY_MSG" | EMAIL=$SENDER_EMAIL mutt -s "$SUBJECT" -c "$CC" -- "$RECIPIENT_EMAILS" 
    else
        echo "Send ok : $RESULTUPLOAD"
    fi
}



main() {
    echo "start time : $(date)"
    for i in "${!tipo_giacenza[@]}"
        do
            ## cleanup logs
            touch log && cp /dev/null log
            touch err.log && cp /dev/null err.log
            echo "download dati dalla intranet per giacenze : ${tipo_giacenza[$i]}"
            get_intranet_file "${tipo_giacenza[$i]}"
            echo "invio dati ftp su takeaway per giacenze : ${tipo_giacenza[$i]}"
            send_via_ftp "${tipo_giacenza[$i]}"
    done
    echo "end time :  $(date)"
    exit
}

main

