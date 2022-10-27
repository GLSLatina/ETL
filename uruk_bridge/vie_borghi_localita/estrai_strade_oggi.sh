#!/bin/sh
awk -Fµ '  $19~"Latina" && $19!~"Scalo" && $19!~"cisterna" && $19!~"Cisterna" && $4!~"WW" && $4!~"LT" && $4!~"MI" && $4!~"M1" && $4!~"M2" && $4!~"VM" && $4!~"M3" && $4!~"M4" && $4!~"R1" && $4!~"R2" && $4!~"R4" && $4!~"R3" && $4!~"NN" && $4!~"NL" {  print $17}' /tmp/arrivi_oggi.txt   | egrep -vi "fermo deposito|KM. 67,500"      > /tmp/arrivi_indirizzi_latina.txt 

agrep -i -f /tmp/borghi_vie.txt /tmp/arrivi_indirizzi_latina.txt > /tmp/arrivi_indirizzi_borghi.txt

egrep -f /tmp/arrivi_indirizzi_borghi.txt /tmp/arrivi_oggi.txt | grep -vi "Romagnoli Carlo"| awk -Fµ  '  (index($9, "no") != 0) && (index($20, "LT") != 0) && ($70!~"LT")  gsub("\"","",$4)  { print "NSPED:",$4$1, "DATA:",$3, "\n","DEST:", $16, $17, $18, $19,"\n","ASSEGNATO:",$9,"NOLO:",$3, "SEDE:",$68,"PESO:", $30, "VOL:", $31, "COLLI:", $29, "\n","MIT:", $11, $13, $15, "\n\n"}' > /tmp/arrivi_borghi_localita_latina.txt

