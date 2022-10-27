############################################################
#   Script per il backup dei db presenti sul sistema       #
#   Dichiarazione delle variabili                          #
############################################################
#!/bin/sh
DLC="/u/dlc10"
NET="//10.58.73.209/serverbackup"
MNT="/mnt/BackupShare"
DIRCP="$MNT/TU"
DB="/u/LATINA/DataBases"
BACKUP="/opt/disk2/LATINA"
LOGIN="/opt/disk2/script/login"
GIORNO=`date +"%w"`
MAILOK="fabio.pietrosanti@gls-italy.com"
MAILTO="assistenza@tunetwork.it,fabio.pietrosanti@gls-italy.com"
MAILFROM="amministrazione@glslatina.it"
MAILLOG="/opt/disk2/script/maillog"
MAILSMTP="127.0.0.1"



###########################################################
#       NON EDITARE NULLA SOTTO QUESTA RIGA               #
###########################################################

#valore di controllo per la modalita' di backup
check=0

#il backup completo viene fatto solo di domenica
tipoBackup=""
if [ $GIORNO != "0" ]
then
   tipoBackup="incremental"
fi

#imposto l'header per la mail ad assistenza
MAILOBJ="Backup `hostname` (LATINA) Fallito!"
echo "[`date`] Resoconto backup" > $MAILLOG

rm -f $BACKUP/*.$GIORNO.bck.bz2

dir=${DB%/}
for nd in `ls $dir/*.db | cut -d "/" -f 5 | cut -d "." -f1` 
do
  backup=$nd.$GIORNO.bck
  $DLC/bin/proutil $dir/$nd -C holder 1>/dev/null
  retcode=$?
#se 0  -> DB Spento, backup offline, send notify
#se 14 -> DB Single User, send notify
#se 16 -> DB MultiUser, backup online
  case $retcode in
	14)	echo "[`date +"%Y-%m-%d"`] Backup di $nd Fallito  -- proutil code: $retcode" >> $MAILLOG
		$DLC/bin/sendEmail -f $MAILFROM -t $MAILTO -u $MAILOBJ -o message-file=$MAILLOG -s $MAILSMTP
		exit 1
		;;
	16) $DLC/bin/probkup online $dir/$nd $tipoBackup $BACKUP/$backup -com -red 7 1>/dev/null
		if [ $? == "0" ] 
		then
			echo "[`date`] $nd [OK]" >> $MAILLOG
		else
			echo "[`date`] Errore durante il backup $nd: Codice di ritorno: $?" >> $MAILLOG
			check=1
		fi
		;;
	0)  $DLC/bin/probkup $dir/$nd $tipoBackup $BACKUP/$backup -com -red 7 1>/dev/null
		if [ $? == "0" ]
		then
			echo "[`date +"%Y-%m-%d"`] Backup di $nd Effettuato Offline" >> $MAILLOG
			check=1
		else
			echo "[`date`] Errore durante il backup $nd: Codice di ritorno: $?" >> $MAILLOG
			check=1
		fi
		;;
	*)  echo "[`date +"%Y-%m-%d"`] Errore backup $nd -- proutil code: $retcode" >> $MAILLOG
	    $DLC/bin/sendEmail -f $MAILFROM -t $MAILTO -u $MAILOBJ -o message-file=$MAILLOG -s $MAILSMTP
        exit 1
		;;
  esac
  echo "[`date`] Backup Effettuati. Compressione del file $backup" >> $MAILLOG
  bzip2 $BACKUP/$backup 1>/dev/null
done

# Copie programmi, ambiente e directory di lavoro

cd /
tar cfz $BACKUP/dlc10.tar u/dlc10
tar cfz $BACKUP/latina.tar u/LATINA/Machine u/LATINA/ItMachine u/LATINA/Depot u/LATINA/Applications u/LATINA/Development opt/disk2/script u/TU
tar cfz $BACKUP/glsdata.tar u/GLSDATA


if [ ! -d $MNT ]
then
  mkdir $MNT
fi

echo "[`date`] Monto la directory remota..." >> $MAILLOG
mount=`mount.cifs $NET $MNT -o credentials=$LOGIN`
if [ $? != "0" ]
then
  echo "[`date`] Problemi durante montaggio disco di rete. Return code: $mount" >> $MAILLOG
  check=2
fi

if [ $check == "0" ]
then
  echo "[`date`] Copia in corso..." >> $MAILLOG
  rm -f $DIRCP/*.$GIORNO.bck.bz2
  rm -f $DIRCP/*.tar
  cp $BACKUP/*.$GIORNO.bck.bz2 $DIRCP/
  if [ $? == "0" ]
  then
    echo "[`date`] Fatto Copie Basedati" >> $MAILLOG
  else
    echo "[`date`] Problemi durante la copia delle basedati sul disco di rete. Codice di ritorno: $?" >> $MAILLOG
    check=2
  fi
  cp $BACKUP/*.tar $DIRCP/
  if [ $? == "0" ]
  then
    echo "[`date`] Fatto Copie Ambiente" >> $MAILLOG
  else
    echo "[`date`] Problemi durante la copia dell'ambiente sul disco di rete. Codice di ritorno: $?" >> $MAILLOG
    check=2
  fi
  echo "[`date`] Smonto la cartella remota" >> $MAILLOG
  umount $MNT
fi

if [ $check != "0" ]
then
  $DLC/bin/sendEmail -f $MAILFROM -t $MAILTO -u $MAILOBJ -o message-file=$MAILLOG -s $MAILSMTP
else 
  MAILOBJ="Backup `hostname` (LATINA) Effettuato con Successo!"
  $DLC/bin/sendEmail -f $MAILFROM -t $MAILOK -u $MAILOBJ -o message-file=$MAILLOG -s $MAILSMTP  
fi

exit 0
