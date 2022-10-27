#!/bin/sh

cd /root/blocklist
# Download Ditte
curl -s 'https://docs.google.com/spreadsheets/export?id=1yZ3TW7XQhq7D6QuZldaCL7uQLrse32Tbz2pAR7-iOTY&exportFormat=tsv' | awk -F\\t '{ print $1}'  | egrep -vi "nome ditta" | sort -rn | uniq > /tmp/ditta.txt

# Download Legali
curl -s 'https://docs.google.com/spreadsheets/export?id=1yZ3TW7XQhq7D6QuZldaCL7uQLrse32Tbz2pAR7-iOTY&exportFormat=tsv' | awk -F\\t '{ print $3}'  | egrep -vi "nome ditta" | sort -rn | uniq > /tmp/legali.txt
