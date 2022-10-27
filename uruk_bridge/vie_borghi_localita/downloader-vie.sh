#!/bin/sh

cd /root/vie_borghi_localita

# Download Vie
curl -s 'https://docs.google.com/spreadsheets/export?id=11X9gbFYu-PKFMKYROrzpJ2T8gegGU7NqvnuktNR3Cvo&exportFormat=tsv' | awk -F\\t '{ print $1}'   > /tmp/borghi_vie.txt

dos2unix /tmp/borghi_vie.txt 2>/dev/null
