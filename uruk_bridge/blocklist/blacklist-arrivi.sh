#!/bin/sh
cd /root/blocklist

## Scarica Blocklist Aggiornato (ditte e rappresentanti legali)
/root/blocklist/downloader-blocklist.sh

## Scarica Arrivi
/root/blocklist/downloader-arrivi.sh >/dev/null

## Fai matching di destinatari di merci con aziende e legali rappresentanti
/root/blocklist/estrai_destinatari.sh

## Prepara e invia email
# /root/blocklist/email.sh
