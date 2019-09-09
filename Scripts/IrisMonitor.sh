#!/bin/bash
##########################################################################################################################################################################################
#                                                                                  IrisMonitor.sh                                                                                       #
#Société IRIS, toute reproduction est interdite sans autorisation                                                                                                                       #
#Ce script permet de tester l'activitée des équipements scannés avec le script IrisScan.sh                                                                                              #
#THIERRY BARDINI                                                                                                                                                                        #
###########################################################################################################################################################################################

##########PING##########

#while [[ true ]]; do
	echo "START : "
	date
	echo ""
	ok=""
	numligne=""
	numlignefinal=""
	resoluNom=""
	truncate -s 0 /media/USBirisbox/DeadIP2.txt

	while read line; do
		echo -e "$line\n"
		
		######################Résolution de Nom			
		numligne=`grep -n -w $line /media/USBirisbox/ResultSCAN.txt`
		#echo $numligne
		numlignefinal=`echo "${numligne%:*}"`
		echo "ligne : $numlignefinal"

		resoluNom=`head -n $numlignefinal /media/USBirisbox/ResultNAME.txt | tail -n 1`
		echo $resoluNom
		########################################

		ping "$line" -q -c 5
    		if [ $? -ne 0 ]; then
        		echo "• $resoluNom ($line) ne répond plus (Découvert le $(date -d 'now' '+%d/%m/%Y') à $(date -d 'now' '+%T'))" >> /media/USBirisbox/DeadIP2.txt;
        		#echo $(date -d 'now' '+%d/%m/%Y') à $(date -d 'now' '+%T') ", L'IP :" $line "ne répond plus" >> /DeadIP2.txt;
		#else
        		#echo $line ping passed;
    		fi
	done < /media/USBirisbox/ResultSCAN.txt

	#cat /DeadIP.txt
	#cat /DeadIP2.txt
	
	if [[ $(cat /media/USBirisbox/DeadIP.txt | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b") == $(cat /media/USBirisbox/DeadIP2.txt | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b") ]]; then
		ok=1
	else
		echo Procédure de mail
		truncate -s 0 /media/USBirisbox/DeadIP.txt
		echo $(sed -n '$=' /media/USBirisbox/DeadIP2.txt)
		if [[ $(sed -n '$=' /media/USBirisbox/DeadIP2.txt) = "" ]]; then
			echo 0 ligne
	                echo "Tout est opérationnel !" >> /media/USBirisbox/DeadIP.txt;
        	        cat /media/USBirisbox/DeadIP.txt | mutt -s 'Bench' irisbox@iris-reseaux.com
		else 
			if [[ $(sed -n '$=' /media/USBirisbox/DeadIP2.txt) = "1" ]]; then 
				echo 1 ligne
				echo "1 Panne découverte"  >> /media/USBirisbox/DeadIP.txt
		                cat /media/USBirisbox/DeadIP2.txt >> /media/USBirisbox/DeadIP.txt;
              			cat /media/USBirisbox/DeadIP.txt | mutt -s 'Panne Bench' irisbox@iris-reseaux.com
				cat /media/USBirisbox/DeadIP.txt | mutt -s 'Panne Bench' thierrybardini+5c8dmq2tfiyht6eojelz@boards.trello.com
			else 
				echo 2 lignes ou plus
				echo $(sed -n '$=' /media/USBirisbox/DeadIP2.txt) " Pannes découvertes" >> /media/USBirisbox/DeadIP.txt
                                cat /media/USBirisbox/DeadIP2.txt >> /media/USBirisbox/DeadIP.txt;
                                cat /media/USBirisbox/DeadIP.txt | mutt -s 'Pannes Bench' irisbox@iris-reseaux.com
                                cat /media/USBirisbox/DeadIP.txt | mutt -s 'Pannes Bench' thierrybardini+5c8dmq2tfiyht6eojelz@boards.trello.com
			fi
		fi	
		#echo $(sed -n '$=' /DeadIP2.txt)  >> /DeadIP.txt
        	#cat /DeadIP2.txt >> /DeadIP.txt;
		#cat /DeadIP.txt | mutt -s 'Pannes Bench' irisbox.alerte@outlook.com
		#if [[ $(cat /DeadIP.txt) == $(cat /FichierVIDE.txt) ]]; then
		#	echo DeadIP vide
		#else
		#	cat /DeadIP.txt | mutt -s 'Pannes Bench' thierrybardini+5c8dmq2tfiyht6eojelz@boards.trello.com
		#fi
	fi
		
	echo "END : "
        date
        echo ""
	#cat /DeadIP.txt
	#cat /DeadIP2.txt

	#sleep 10m
#done

