#!/bin/bash
###########################################################################################################################################################################################
#                                                                                  IrisScan.sh                                                                                         #
#Société IRIS, toute reproduction est interdite sans autorisation                                                                                                                      #
#Ce script permet de scanner les adresses ip actives d'une plage donnée                                                                                                                #
#THIERRY BARDINI                                                                                                                                                                       #
###########################################################################################################################################################################################

> /media/USBirisbox/ResultSCAN.txt

##########Demande le nombre de VLAN########## 

echo "Saisissez le nombre de VLAN sur cette infrastructure"
select i in "1/Réseau simpliste" "2 VLAN" "3 VLAN" "4 VLAN"; do
	echo $i
	if [[ $i = "1/Réseau simpliste" ]]; then
		nbVlan=1
		break
	elif [[ $i = "2 VLAN" ]]; then
		nbVlan=2
		break   
	elif [[ $i = "3 VLAN" ]]; then
                nbVlan=3
		break
	elif [[ $i = "4 VLAN" ]]; then
                nbVlan=4
		break
	else 
		echo "Erreur"
		exit
	fi	
done

#if [[ $nbVlan < 5 ]]; then
#	echo "vlan -5"
#fi

compteur0=0
nbHost=0
nVLAN=1
#echo $compteur0
#echo $nbVlan
#let compteur0=$compteur0+1
#echo $compteur0

while [[ $compteur0 < $nbVlan ]]; do

	##########1ere IP de la plage##########
	until [[ ${ip1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]]; 
	do
		echo "Saisissez la PREMIERE ip de votre plage d'adresse (VLAN n°"$nVLAN")"
		read ip1
		ip1=$ip1.
	done
	#echo $ip1 >> PlageIP.txt

	##########2e IP de la plage##########
	until [[ ${ip2} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]]; do
		echo "Saisissez la DERNIERE ip de votre plage d'adresse (VLAN n°"$nVLAN")"

		read ip2
		ip2=$ip2.
	done
	#echo $ip2 >> PlageIP.txt

	##########Longueur des chaines##########
	longIP1=${#ip1}
	longIP2=${#ip2}
	#echo $longIP1 >> PlageIP.txt

	##########Décomposer les IP entrées##########
	point='.'
	#####IP1#####
	compteur=0
	valeur1=""
	valeur11=""
	valeur12=""
	valeur13=""
	valeur14=""

	while [[ $compteur -le $longIP1 && $valeur1 != $point ]]; do
		valeur1=`expr substr $ip1 $compteur 1`
		#echo $valeur1
		let compteur=$compteur+1
		if [[ $valeur1 != $point ]]; then
			valeur11=$valeur11$valeur1
			#echo $valeur11
		#else
                	#echo $valeur11
		fi
	done
	valeur1=`expr substr $ip1 $compteur 1`
	while [[ $compteur -le $longIP1 && $valeur1 != $point ]]; do
        	valeur1=`expr substr $ip1 $compteur 1`
        	#echo $valeur1
        	let compteur=$compteur+1
        	if [[ $valeur1 != $point ]]; then
                	valeur12=$valeur12$valeur1
                	#echo $valeur12
        	#else
                	#echo $valeur12
        	fi
	done
	valeur1=`expr substr $ip1 $compteur 1`
	while [[ $compteur -le $longIP1 && $valeur1 != $point ]]; do
	        valeur1=`expr substr $ip1 $compteur 1`
	        #echo $valeur1
	        let compteur=$compteur+1
	        if [[ $valeur1 != $point ]]; then
	                valeur13=$valeur13$valeur1
        	        #echo $valeur13
       		#else
        	        #echo $valeur13
     		fi
	done
	valeur1=`expr substr $ip1 $compteur 1`
	while [[ $compteur -le $longIP1 && $valeur1 != $point ]]; do
        	valeur1=`expr substr $ip1 $compteur 1`
        	#echo $valeur1
        	let compteur=$compteur+1
        	if [[ $valeur1 != $point ]]; then
                	valeur14=$valeur14$valeur1
                	#echo $valeur14
        	#else
                	#echo $valeur14
        	fi
	done

	#####IP2#####
	compteur=0
	valeur2=""
	valeur21=""
	valeur22=""
	valeur23=""
	valeur24=""

	while [[ $compteur -le $longIP2 && $valeur2 != $point ]]; do
        	valeur2=`expr substr $ip2 $compteur 1`
        	#echo $valeur2
        	let compteur=$compteur+1
        	if [[ $valeur2 != $point ]]; then
                	valeur21=$valeur21$valeur2
                	#echo $valeur21
        	#else
                	#echo $valeur21
        	fi
	done
	valeur2=`expr substr $ip2 $compteur 1`
	while [[ $compteur -le $longIP2 && $valeur2 != $point ]]; do
        	valeur2=`expr substr $ip2 $compteur 1`
        	#echo $valeur2
        	let compteur=$compteur+1
        	if [[ $valeur2 != $point ]]; then
                	valeur22=$valeur22$valeur2
                	#echo $valeur22
        	#else
                	#echo $valeur22
        	fi
	done
	valeur2=`expr substr $ip2 $compteur 1`
	while [[ $compteur -le $longIP2 && $valeur2 != $point ]]; do
        	valeur2=`expr substr $ip2 $compteur 1`
        	#echo $valeur2
        	let compteur=$compteur+1
        	if [[ $valeur2 != $point ]]; then
                	valeur23=$valeur23$valeur2
                	#echo $valeur23
        	#else
                	#echo $valeur23
        	fi
	done
	valeur2=`expr substr $ip2 $compteur 1`
	while [[ $compteur -le $longIP2 && $valeur2 != $point ]]; do
        	valeur2=`expr substr $ip2 $compteur 1`
        	#echo $valeur2
        	let compteur=$compteur+1
        	if [[ $valeur2 != $point ]]; then
                	valeur24=$valeur24$valeur2
                	#echo $valeur24
        	#else
                	#echo $valeur24
        	fi
	done


	###########Comparer les entrées##########
	valeurF1=""
	valeurF2=""
	valeurF3=""
	valeurF4=""

	if [[ $valeur11 < $valeur21 ]]; then
		valeurF1=$valeur11-$valeur21
		#echo $valeurF1
	else
		if [[ $valeur21 < $valeur11 ]]; then
			echo "Erreur de plage (1), relancez le programme"
			exit
		else
			valeurF1=$valeur11
		fi
	fi
	#echo $valeurF1

	if [[ $valeur12 < $valeur22 ]]; then
        	valeurF2=$valeur12-$valeur22
        	#echo $valeurF2
	else
        	if [[ $valeur22 < $valeur12 ]]; then
                	echo "Erreur de plage (2), relancez le programme"
			exit
		else
                	valeurF2=$valeur12
        	fi
	fi
	#echo $valeurF2

	if [[ $valeur13 < $valeur23 ]]; then
        	valeurF3=$valeur13-$valeur23
        	#echo $valeurF3
	else
        	if [[ $valeur23 < $valeur13 ]]; then
                	echo "Erreur de plage (3), relancez le programme"
			exit
		else
                	valeurF3=$valeur13
        	fi
	fi
	#echo $valeurF3

	if [[ $valeur14 < $valeur24 ]]; then
        	valeurF4=$valeur14-$valeur24
        	#echo $valeurF4
	else
        	if [[ $valeur24 < $valeur14 ]]; then
                	echo "Erreur de plage (4), relancez le programme"
			exit
		else
                	valeurF4=$valeur14
        	fi
	fi
	#echo $valeurF4

	##########NMAP##########
	echo -e "\n" "Nmap en cours d'éxécution sur cette plage d'adresse : " $valeurF1.$valeurF2.$valeurF3.$valeurF4
	sudo nmap $valeurF1.$valeurF2.$valeurF3.$valeurF4 -n -sn -oG - | awk '/Up$/{print $2}' >> /media/USBirisbox/ResultSCAN.txt
	echo -e "\n" "Scan ternimé, les résultat se trouvent dans le fichier ResultSCAN.txt présent sur la clé USB"
	#echo $(sed -n '$=' /ResultSCAN.txt)
	nbH=$(sed -n '$=' /media/USBirisbox/ResultSCAN.txt)
	let nbH=$nbH-$nbHost 
	#echo $nbHost
	echo -e "\n" "IrisBox a trouvé :" $nbH "IP sur ce VLAN"
	echo -e "\n"

let compteur0=$compteur0+1
let nVLAN=$nVLAN+1
let nbHost=$(sed -n '$=' /media/USBirisbox/ResultSCAN.txt)

ip1=""
ip2=""

done

nbHT=$(sed -n '$=' /media/USBirisbox/ResultSCAN.txt)
echo -e "\n" "Total d'Hôtes découverts :" $nbHT
echo -e "\n"

exit
