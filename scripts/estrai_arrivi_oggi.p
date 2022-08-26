OUTPUT TO /u/users/t99/openedge/scripts/tmp/arrivi_oggi.txt.
FOR EACH zabolle WHERE zabolle.za-data = DATA_DA_SOSTITUIRE  NO-LOCK:
           EXPORT DELIMITER "~265"
                        za-nsped za-tsped za-data za-sede za-cli za-fat za-ut za-bf za-porto za-piva za-mitt za-mcap za-mcit za-mindi za-mprov za-dest za-dindi za-dcap za-dcit za-dprov za-fp za-tlist za-lprov za-lfp za-scol1 za-scol2 za-bda za-cont za-cnum za-peso za-pevo za-ca za-fca za-nolo za-fisdir za-dass za-ass za-cvar za-var za-ant za-impo za-iva za-aftot za-inctot za-fcomp za-acomp za-fsta za-cpag za-note za-lclicod za-codiva za-codnote za-impass za-desvar za-altip za-oper za-fant za-altre za-vdprov za-acli za-asede za-rfp za-prit za-conlis za-bnsped za-cdata za-cora za-cfirma za-cnote za-clipag za-tnsped za-pdata
                za-altrex[1] za-altrex[2] za-altrex[3] za-altrex[4] za-altrex[5] za-altrex[6] za-altrex[7] za-altrex[8] za-altrex[9] za-altrex[10] za-altrex[11] za-altrex[12] za-altrex[13] za-altrex[14] za-altrex[15] za-altrex[16] za-altrex[17] za-altrex[18] za-altrex[19] za-altrex[20] za-altrex[21] za-altrex[22] za-altrex[23] za-altrex[24] za-altrex[25] za-altrex[26] za-altrex[27] za-altrex[28] za-altrex[29] za-altrex[30]
                za-altren[1] za-altren[2] za-altren[3] za-altren[4] za-altren[5] za-altren[6] za-altren[7] za-altren[8] za-altren[9] za-altren[10] za-altren[11] za-altren[12] za-altren[13] za-altren[14] za-altren[15] za-altren[16] za-altren[17] za-altren[18] za-altren[19] za-altren[20] za-altren[21] za-altren[22] za-altren[23] za-altren[24] za-altren[25] za-altren[26] za-altren[27] za-altren[28] za-altren[29] za-altren[30] 
                za-serv
          .

END.
OUTPUT close.
