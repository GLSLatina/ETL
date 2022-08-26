OUTPUT TO /u/users/t99/openedge/scripts/tmp/partenze_4_mesi.csv.
FOR EACH zbolle WHERE zbolle.b-data > DATA_DA_SOSTITUIRE NO-LOCK:
           EXPORT DELIMITER "~265"

b-nsped b-tsped b-data b-sede b-cli b-fat b-ut b-bf b-porto b-piva b-mitt b-mcap b-mcit b-mindi b-mprov b-dest b-dindi b-dcap b-dcit b-dprov b-fp b-tlist b-lprov b-lfp b-scol1 b-scol2 b-bda b-cont b-cnum b-peso b-pevo b-ca b-fca b-nolo b-fisdir b-dass b-ass b-cvar b-var b-ant b-impo b-iva b-aftot b-inctot b-fcomp b-acomp b-fsta b-cpag b-note b-lclicod b-codiva b-codnote b-impass b-desvar b-altip b-oper b-fant b-altre[1] b-altre[2] b-altre[3] b-altre[4] b-altre[5] b-altre[6] b-altre[7] b-altre[8] b-altre[9] b-altre[10] b-vdprov b-acli b-impabb b-numabb b-vmprov b-rfp b-falt b-rif[1] b-rif[2] b-rif[3] b-forz b-asede b-giac b-prit b-conlis b-nsb b-cdata b-cora b-cfirma b-cnote b-numfat b-clipag b-pdata b-altrex[1] b-altrex[2] b-altrex[3] b-altrex[4] b-altrex[5] b-altrex[6] b-altrex[7] b-altrex[8] b-altrex[9] b-altrex[10] b-altrex[11] b-altrex[12] b-altrex[13] b-altrex[14] b-altrex[15] b-altrex[16] b-altrex[17] b-altrex[18] b-altrex[19] b-altrex[20] b-altrex[21] b-altrex[22] b-altrex[23] b-altrex[24] b-altrex[25] b-altrex[26] b-altrex[27] b-altrex[28] b-altrex[29] b-altrex[30] b-altren[1] b-altren[2] b-altren[3] b-altren[4] b-altren[5] b-altren[6] b-altren[7] b-altren[8] b-altren[9] b-altren[10] b-altren[11] b-altren[12] b-altren[13] b-altren[14] b-altren[15] b-altren[16] b-altren[17] b-altren[18] b-altren[19] b-altren[20] b-altren[21] b-altren[22] b-altren[23] b-altren[24] b-altren[25] b-altren[26] b-altren[27] b-altren[28] b-altren[29] b-altren[30] b-serv

           .

END.
OUTPUT close.
