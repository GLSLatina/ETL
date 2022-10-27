#!/bin/sh
# Ottimizzatore Partenze
# Fabio Pietrosanti - GLS Latina
# 
# Rileva:
#  1 - Presenza di un numero di telefono nel campo Note
#  2 - Presenza di una email legata alla spedizione per notifica
#
#  3 - Non effettuazione di weblabeling
#
#  4 - Avere forzato l’indirizzo
#  altre7: " ??"
#
#  5 - Indirizzo senza presenza di “virgola” 
# 
#  6 - Indirizzo senza presenza di numero (civico e/o km)

shopt -s nullglob

# includi parser numero telefono
#. ./check_numero.sh

# Debug components
DEBUGADDRESS=true
DEBUGTEL=true
DEBUGNOTE=true

FILE=/tmp/partenze_oggi.csv
#FILE=../estrai_partenze_forzati.txt

cat $FILE| while IFS='µ' read  nsped tsped data sede cli fat ut bf porto piva mitt mcap mcit mindi mprov dest dindi dcap dcit dprov fp tlist lprov lfp scol1 scol2 bda cont cnum peso pevo ca fca nolo fisdir dass ass cvar var ant impo iva aftot inctot fcomp acomp fsta cpag note lclicod codiva codnote impass desvar altip oper fant altre1 altre2 altre3 altre4 altre5 altre6 altre7 altre8 altre9 altre10 vdprov acli impabb numabb vmprov rfp falt rif1 rif2 rif3 forz asede giac prit conlis nsb cdata cora cfirma cnote numfat clipag pdata altrex1 altrex2 altrex3 altrex4 altrex5 altrex6 altrex7 altrex8 altrex9 altrex10 altrex11 altrex12 altrex13 altrex14 altrex15 altrex16 altrex17 altrex18 altrex19 altrex20 altrex21 altrex22 altrex23 altrex24 altrex25 altrex26 altrex27 altrex28 altrex29 altrex30 altren1 altren2 altren3 altren4 altren5 altren6 altren7 altren8 altren9 altren10 altren11 altren12 altren13 altren14 altren15 altren16 altren17 altren18 altren19 altren20 altren21 altren22 altren23 altren24 altren25 altren26 altren27 altren28 altren29 altren30 serv; do 

#	echo $nsped $tsped $data $sede $cli $fat $ut $bf $porto $piva $mitt $mcap $mcit $mindi $mprov $dest $dindi $dcap $dcit $dprov $fp $tlist $lprov $lfp $scol1 $scol2 $bda $cont $cnum $peso $pevo $ca $fca $nolo $fisdir $dass $ass $cvar $var $ant $impo $iva $aftot $inctot $fcomp $acomp $fsta $cpag $note $lclicod $codiva $codnote $impass $desvar $altip $oper $fant $altre1 $altre2 $altre3 $altre4 $altre5 $altre6 $altre7 $altre8 $altre9 $altre10 $vdprov $acli $impabb $numabb $vmprov $rfp $falt $rif1 $rif2 $rif3 $forz $asede $giac $prit $conlis $nsb $cdata $cora $cfirma $cnote $numfat $clipag $pdata $altrex1 $altrex2 $altrex3 $altrex4 $altrex5 $altrex6 $altrex7 $altrex8 $altrex9 $altrex10 $altrex11 $altrex12 $altrex13 $altrex14 $altrex15 $altrex16 $altrex17 $altrex18 $altrex19 $altrex20 $altrex21 $altrex22 $altrex23 $altrex24 $altrex25 $altrex26 $altrex27 $altrex28 $altrex29 $altrex30 $altren1 $altren2 $altren3 $altren4 $altren5 $altren6 $altren7 $altren8 $altren9 $altren10 $altren11 $altren12 $altren13 $altren14 $altren15 $altren16 $altren17 $altren18 $altren19 $altren20 $altren21 $altren22 $altren23 $altren24 $altren25 $altren26 $altren27 $altren28 $altren29 $altren30 $serv
#	echo nsped: $nsped tsped: $tsped data: $data sede: $sede cli: $cli fat: $fat ut: $ut bf: $bf porto: $porto piva: $piva mitt: $mitt mcap: $mcap mcit: $mcit mindi: $mindi mprov: $mprov dest: $dest dindi: $dindi dcap: $dcap dcit: $dcit dprov: $dprov fp: $fp tlist: $tlist lprov: $lprov lfp: $lfp scol1: $scol1 scol2: $scol2 bda: $bda cont: $cont cnum: $cnum peso: $peso pevo: $pevo ca: $ca fca: $fca nolo: $nolo fisdir: $fisdir dass: $dass ass: $ass cvar: $cvar var: $var ant: $ant impo: $impo iva: $iva aftot: $aftot inctot: $inctot fcomp: $fcomp acomp: $acomp fsta: $fsta cpag: $cpag note: $note lclicod: $lclicod codiva: $codiva codnote: $codnote impass: $impass desvar: $desvar altip: $altip oper: $oper fant: $fant altre1: $altre1 altre2: $altre2 altre3: $altre3 altre4: $altre4 altre5: $altre5 altre6: $altre6 altre7: $altre7 altre8: $altre8 altre9: $altre9 altre10: $altre10 vdprov: $vdprov acli: $acli impabb: $impabb numabb: $numabb vmprov: $vmprov rfp: $rfp falt: $falt rif1: $rif1 rif2: $rif2 rif3: $rif3 forz: $forz asede: $asede giac: $giac prit: $prit conlis: $conlis nsb: $nsb cdata: $cdata cora: $cora cfirma: $cfirma cnote: $cnote numfat: $numfat clipag: $clipag pdata: $pdata altrex1: $altrex1 altrex2: $altrex2 altrex3: $altrex3 altrex4: $altrex4 altrex5: $altrex5 altrex6: $altrex6 altrex7: $altrex7 altrex8: $altrex8 altrex9: $altrex9 altrex10: $altrex10 altrex11: $altrex11 altrex12: $altrex12 altrex13: $altrex13 altrex14: $altrex14 altrex15: $altrex15 altrex16: $altrex16 altrex17: $altrex17 altrex18: $altrex18 altrex19: $altrex19 altrex20: $altrex20 altrex21: $altrex21 altrex22: $altrex22 altrex23: $altrex23 altrex24: $altrex24 altrex25: $altrex25 altrex26: $altrex26 altrex27: $altrex27 altrex28: $altrex28 altrex29: $altrex29 altrex30: $altrex30 altren1: $altren1 altren2: $altren2 altren3: $altren3 altren4: $altren4 altren5: $altren5 altren6: $altren6 altren7: $altren7 altren8: $altren8 altren9: $altren9 altren10: $altren10 altren11: $altren11 altren12: $altren12 altren13: $altren13 altren14: $altren14 altren15: $altren15 altren16: $altren16 altren17: $altren17 altren18: $altren18 altren19: $altren19 altren20: $altren20 altren21: $altren21 altren22: $altren22 altren23: $altren23 altren24: $altren24 altren25: $altren25 altren26: $altren26 altren27: $altren27 altren28: $altren28 altren29: $altren29 altren30: $altren30 serv: $serv

# DEBUG ALTREX13 WITH CONTACT INFORMATION

#if ( test "$altrex13" != "\"\"" ); then
	#echo $nsped~$tsped~$altrex13
#	echo $altrex13
#fi

# Reset variabili usate
unset INDIRIZZOFORZATO
unset MISSINGVIRGOLA
unset MISSINGNUMERO
unset NOTWEBLABELING
unset TESTCAMPONOTE
unset DIGITSCAMPONOTE
unset DIGITSCAMPONOTEZERO
unset DIGITSCAMPONOTEFIRST
unset INTERNAZIONALE
unset sizecamponote
unset sizedigitscamponote
unset TELEFONO
unset TELEFONOALTREX13
unset CAMPONOTE
unset TESTALTRE7

if !(test $1);then
	echo Specifica tipo di spedizione
	exit
fi
# Processiamo solo le spedizioni in partenza di tipo 1
if [[ $tsped = $1 ]]; then

# Check indirizzi forzati in partenza

#	if ( [[ $altre7 =~ .*\?\?.* ]] || [[ $altre7 = '""' ]]  )  ; then

#TESTALTRE7=`echo $altre7 | egrep -v '[a-z]' | wc -c` 
#echo $TESTALTRE7 $altre7

#if (test "$TESTALTRE7" -le 4 ) ; then
#	echo NOTOK: $TESTALTRE7 altre7 $altre7
#fi



#	if  [[ $altre7 =~ .*\?\?.* ]]   ; then
	if ! ( [[ $dindi =~ "FERMO DEPOSITO" ]] || [[ $dindi =~ "fermo deposito" ]] ) ; then
		if ! ( [[ $altre7 =~ .*[a-z].* ]] || [[ $altre7 =~ .*[A-Z].* ]] ||  [[ $altre7 =~ .*[0-9].* ]] )  ; then
		INDIRIZZOFORZATO=1

			if($DEBUGADDRESS); then 
				echo -n IND-FORZATI:
				echo  SPED:$nsped MITT:"$mitt" DEST:"$dindi" $vdprov altre7:$altre7
			fi

		else
			INDIRIZZOFORZATO=0

		fi
	fi

	
# Controllo indirizi, solo su NON fermo deposito
	if ! ( [[ $dindi =~ "FERMO DEPOSITO" ]] || [[ $dindi =~ "fermo deposito" ]] ) ; then

# Check indirizzi senza virgola
		if !( [[ $dindi =~ .*,.*  ]] ) ; then
		MISSINGVIRGOLA=1

			if($DEBUGADDRESS); then 
				echo -n IND-VIRGOLA:
				echo  SPED:$nsped MITT:"$mitt" DEST:"$dindi" $vdprov
			fi
		else
		MISSINGVIRGOLA=0
		fi

# Check indirizzi senza numero
		if !( [[ $dindi =~ [0-9]  ]]) ; then
		MISSINGNUMERO=1

			if($DEBUGADDRESS); then 
				echo -n IND-NUMERO:
				echo  SPED:$nsped MITT:"$mitt" DEST:"$dindi" $vdprov
			fi
		else
		MISSINGNUMERO=0
		fi

	fi
	

# Check weblabeling
	if !( [[ $nsped =~ ^5.* ]]) ; then
	NOTWEBLABELING=1

			if($DEBUGADDRESS); then 
				echo -n NON-WEBLABELING:
				echo  SPED:$nsped MITT:$mitt DEST:$dindi $vdprov
			fi
	else
	NOTWEBLABELING=0
	fi

if ! ( [[ $dindi =~ "FERMO DEPOSITO" ]] || [[ $dindi =~ "fermo deposito" ]] ) ; then

if ( test "$note" != "\"\"" ); then
		CAMPONOTE=1
# Check se c'è un numero di telefono
	TESTCAMPONOTE=`echo $note | egrep "004178|004179|4179|4178|010|011|0121|0122|0123|0124|0125|0131|0141|0142|0143|0144|015|0161|0163|0165|0166|0171|0172|0173|0174|0175|0182|0183|0184|0185|0187|019|02|030|031|0321|0322|0323|0324|0331|0332|0341|0342|0343|0344|0345|0346|035|0362|0363|0364|0365|0371|0372|0373|0374|0375|0376|0377|0381|0382|0383|0384|0385|0386|039|040|041|0421|0422|0423|0424|0425|0426|0427|0428|0429|0431|0432|0433|0434|0435|0436|0437|0438|0439|0442|0444|0445|045|0461|0462|0463|0464|0465|0471|0472|0473|0474|0481|049|050|051|0521|0522|0523|0524|0525|0532|0533|0534|0535|0536|0541|0542|0543|0544|0545|0546|0547|0549|055|0564|0565|0566|0571|0572|0573|0574|0575|0577|0578|0583|0584|0585|0586|0587|0588|059|06|070|071|0721|0722|0731|0732|0733|0734|0735|0736|0737|0742|0743|0744|0746|075|0761|0763|0765|0766|0771|0773|0774|0775|0776|0781|0782|0783|0784|0785|0789|079|080|081|0823|0824|0825|0827|0828|0831|0832|0833|0835|0836|085|0861|0862|0863|0864|0865|0871|0872|0873|0874|0875|0881|0882|0883|0884|0885|089|090|091|0921|0922|0923|0924|0925|0931|0932|0933|0934|0935|0941|0942|095|0961|0962|0963|0964|0965|0966|0967|0968|0971|0972|0973|0974|0975|0976|0981|0982|0983|0984|0985|099|397|393|392|391|390|389|388|385|384|383|380|377|375|373|371|370|368|366|363|362|361|360|351|350|349|348|347|346|345|344|343|342|341|340|339|338|337|336|335|334|333|331|330|329|328|327|324|323|322|320|313" | tr -d \" | egrep -v 'RICONS. SP.N.|BANCARIO|STORNO|DA SPED|RILASCI|ADD/A|SPED.N.|Reso C/A|Vedi Distinta|C/Ass|C/ASSEGNO|EXCHANGE|INOLTRO|DOCUMENT RETURN|NC GIAC|var porto' `

        if(test "$TESTCAMPONOTE"); then
# Prova a pulire e normalizzare estraendo i soli numeri
			  DIGITSCAMPONOTE="${TESTCAMPONOTE//[!0-9]/}"
# Prendiamo la dimensione del numero
			  sizedigitscamponote=${#DIGITSCAMPONOTE} 
# Validiamo, solo sul NAZIONALE, se è solo numerico e se la lunghezza è fra 7 e 12 digits
			  if ( 
				[ "$sizedigitscamponote" -ge 6 -a "$sizedigitscamponote" -le 25 ] 
			     ) ; then
					TELEFONO=1
			  else
					TELEFONO=0
					if($DEBUGTEL); then 
						echo -n NON-TEL-NOTE:
						echo  SPED:$nsped MITT:"$mitt" DEST:"$dindi" $vdprov NOTE:"$note"
					fi
			  fi
	else
			TELEFONO=0
					if($DEBUGTEL); then 
						echo -n NON-TEL-NOTE:
						echo  SPED:$nsped MITT:"$mitt" DEST:"$dindi" $vdprov NOTE:"$note"
					fi
	fi


	else
		CAMPONOTE=0
					if($DEBUGNOTE); then 
						echo -n NON-TEL-NOTE:
						echo  SPED:$nsped MITT:$mitt DEST:$dindi $vdprov NOTE:$note
					fi
 fi
fi
#echo $nsped~$tsped~$data~$sede~$cli~$fat~$ut~$bf~$porto~$piva~$mitt~$mcap~$mcit~$mindi~$mprov~$dest~$dindi~$dcap~$dcit~$dprov~$fp~$tlist~$lprov~$lfp~$scol1~$scol2~$bda~$cont~$cnum~$peso~$pevo~$ca~$fca~$nolo~$fisdir~$dass~$ass~$cvar~$var~$ant~$impo~$iva~$aftot~$inctot~$fcomp~$acomp~$fsta~$cpag~$note~$lclicod~$codiva~$codnote~$impass~$desvar~$altip~$oper~$fant~$altre1~$altre2~$altre3~$altre4~$altre5~$altre6~$altre7~$altre8~$altre9~$altre10~$vdprov~$acli~$impabb~$numabb~$vmprov~$rfp~$falt~$rif1~$rif2~$rif3~$forz~$asede~$giac~$prit~$conlis~$nsb~$cdata~$cora~$cfirma~$cnote~$numfat~$clipag~$pdata~$altrex1~$altrex2~$altrex3~$altrex4~$altrex5~$altrex6~$altrex7~$altrex8~$altrex9~$altrex10~$altrex11~$altrex12~$altrex13~$altrex14~$altrex15~$altrex16~$altrex17~$altrex18~$altrex19~$altrex20~$altrex21~$altrex22~$altrex23~$altrex24~$altrex25~$altrex26~$altrex27~$altrex28~$altrex29~$altrex30~$altren1~$altren2~$altren3~$altren4~$altren5~$altren6~$altren7~$altren8~$altren9~$altren10~$altren11~$altren12~$altren13~$altren14~$altren15~$altren16~$altren17~$altren18~$altren19~$altren20~$altren21~$altren22~$altren23~$altren24~$altren25~$altren26~$altren27~$altren28~$altren29~$altren30~$serv~$INDIRIZZOFORZATO~$MISSINGVIRGOLA~$MISSINGNUMERO~$NOTWEBLABELING~$CAMPONOTE~$TELEFONO

#if ( test "$altrex13" != "\"\"" ); then
#	echo $nsped~$tsped~$altrex13
#fi

#echo $note
echo ""

# fine ciclo finale di processamento spedizioni di tipo 1
fi

done 

#
#RILEVA BOLLE CON NOTE VUOTO
#sort -r -t \" -k 5 find-zbolle-note.txt | awk -F~ ' ($4!~"00")   { print $1, $2, $3, $4, $11, $16, $49}'   | grep \"\"  | mailx -s "Spedizioni 30/11/2015 Senza Note" fabio.pietrosanti@glslatina.it
#
#RILEVARE SE INDIRIZZO FORZATO:
#t99@lts1:~/openedge> grep 550128903 find-zbolle-note.txt  | awk -F~ '{ print $64}'
#"     ??"
