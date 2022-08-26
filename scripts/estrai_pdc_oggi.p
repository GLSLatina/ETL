OUTPUT TO /u/users/t99/openedge/scripts/tmp/pdc_oggi.txt.
FOR EACH zpdc WHERE zpdc.zp-data > DATA_DA_SOSTITUIRE  NO-LOCK:
           EXPORT DELIMITER "~265"
                zp-sede zp-nsped zp-codaut zp-data zp-cdata zp-note zp-giac zp-cons zp-altre zp-pdata zp-altrex zp-altren
                zp-altrex[1] zp-altrex[2] zp-altrex[3] zp-altrex[4] zp-altrex[5] zp-altrex[6] zp-altrex[7] zp-altrex[8] zp-altrex[9] zp-altrex[10] zp-altrex[11] zp-altrex[12] zp-altrex[13] zp-altrex[14] zp-altrex[15] zp-altrex[16] zp-altrex[17] zp-altrex[18] zp-altrex[19] zp-altrex[20]
                zp-altren[1] zp-altren[2] zp-altren[3] zp-altren[4] zp-altren[5] zp-altren[6] zp-altren[7] zp-altren[8] zp-altren[9] zp-altren[10] zp-altren[11] zp-altren[12] zp-altren[13] zp-altren[14] zp-altren[15] zp-altren[16] zp-altren[17] zp-altren[18] zp-altren[19] zp-altren[20]
          .

END.
OUTPUT close.
