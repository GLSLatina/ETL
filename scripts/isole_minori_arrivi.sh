#!/bin/bash
#
# Controllo Isole Minori
#
# 


cd /u/users/t99/openedge/scripts

./estrai_partenze.sh

awk -Fµ '($20~"VBL\"")  || ($20~"VML\"")  || ($20~"V5N\"") || ($20~"V5L\"") || ($20~"V5I\"") || ($20~"TPI\"") || ($20~"SSI\"") || ($20~"RTL\"") || ($20~"PII\"") || ($20~"PGL\"") || ($20~"PAW\"") || ($20~"PAI\"") || ($20~"OWI\"") || ($20~"NNI\"") || ($20~"NLI\"") || ($20~"LTI\"") || ($20~"LII\"") || ($20~"KGI\"") || ($20~"GTI\"") || ($20~"CTI\"") || ($20~"CHI\"") || ($20~"BSL\"") || ($20~"AGI\"") { print $1,$9,$11,$16,$17,$18,$19,$20,$44,$45}'  tmp/partenze_oggi.csv  | grep -v yes
