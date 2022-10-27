#!/bin/sh
cd /root/blocklist
mkdir -p tmp

# Estrai destinatari dargli arrivi
grep '/15µ"' /var/www/html/zabolle-full.txt | awk -Fµ '{ print $16}' | egrep -vi GLS | sort -rn | uniq > /tmp/destinatari.txt

# Fai approximate match
agrep -i -f /tmp/ditta.txt /tmp/destinatari.txt > /tmp/match-ditta.txt
agrep -i -f /tmp/legali.txt /tmp/destinatari.txt > /tmp/match-legali.txt

# Dai match, rielabora base dati arrivi
egrep -f /tmp/match-ditta.txt /var/www/html/zabolle-full.txt | awk -Fµ  ' { print "NSPED:",$1, "DATA:",$3, "\n","DEST:", $16, $17, $19,"\n","ASSEGNATO:",$9,"NOLO:",$34, "SEDE PAGANTE:",$70,"PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}' > /tmp/arrivi_blocklist-ditta.txt
egrep -f /tmp/match-legali.txt /var/www/html/zabolle-full.txt | awk -Fµ  ' { print "NSPED:",$1, "DATA:",$3, "\n","DEST:", $16, $17, $19,"\n","ASSEGNATO:",$9,"NOLO:",$34, "SEDE PAGANTE:",$70,"PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "SEDE:", $4 "\n\n"}' > /tmp/arrivi_blocklist-legali.txt
