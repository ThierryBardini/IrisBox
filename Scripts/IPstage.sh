#!/bin/bash
##############################################################################################################################################################$
#                                                                                  IPstage.sh                                                                 $
#Société IRIS, toute reproduction est interdite sans autorisation                                                                                             $
#Ce script permet de scanner les adresses ip actives d'une plage donnée                                                                                       $
#THIERRY BARDINI                                                                                                                                              $
##############################################################################################################################################################$

########### Declaration des variables pour connaître ses IP ###########

IP=`ifconfig | grep inet | grep -v -E 'inet6|127.0.0.1' | tr -d [:alpha:] | tr -s [:space:] | cut -d: -f2`
IP2=`hostname -I`
gw=`echo $IP | cut -d. -f1-3`.1



########### Affiche le resultat des IP ###########

echo "Paramètres actuels : "
echo »» IP : $IP2
echo »» Passerelle effective : $gw



########### Configuration de la nouvelle IP ###########

echo ""
echo "Configuration de la nouvelle IP principale"

until [[ ${ip1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
	do
                echo "Saisissez votre IP principale :"
                read ip1
                ip1=$ip1
        done
echo ""
until [[ ${mask} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
        do
                echo "Saisissez votre Masque :"
                read mask
                mask=$mask
        done
echo ""
until [[ ${passl} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
        do
                echo "Saisissez votre Passerelle effective :"
                read passl
                passl=$passl
        done
echo ""
until [[ ${dns} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
        do
                echo "Saisissez votre DNS :"
                read dns
                dns=$dns
        done
echo ""


########### Confirmation 1 ###########

echo "------------------------------------------------------------------------------------------------------"
echo "Voici les paramètres entrés. Voulez vous confirmer ?"
echo "IP : " $ip1
echo "Masque : "$mask
echo "Passerelle effective : "$passl
echo "DNS : "$dns
echo " "

#Choix de valider ou non

LISTE=("[o] Oui" "[n] Non (Fermera le programme sans enregistrer)")  # liste de choix disponibles
select CHOIX in "${LISTE[@]}" ; do
    case $REPLY in
        1|o|O)
        echo "Paramètres ci-dessus validés"
        break
        ;;
        2|n|N)
        exit
        break
        ;;
    esac
done

echo ""


## GROS CHOIX MULTIPLE pour ip Vlanisées

echo "Souhaitez-vous une, ou plusieurs IP Vlanisées supplémentaires ?"
select i in "1 IP supplémentaire" "2 IP supplémentaires" "Non"; do
        echo $i

        if [[ $i = "Non" ]]; then
                echo "L'IrisBox va redémarrer dans 30 secondes. Veuillez patienter"
		sleep 30
		echo "Redémarrage"                
		break

        elif [[ $i = "1 IP supplémentaire" ]]; then
                echo ""
		
		until [[ ${nvlan1} =~ ([1-9]?[0-9]?[0-9]) ]];
		do
		echo "Numéro du VLAN :"
		read nvlan1
		nvlan1=eth0.$nvlan1
		#echo $nvlan1
		echo ""
		done

		until [[ ${ipvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
       	 	do
                echo "Saisissez votre IP pour ce VLAN :"
                read ipvlan1
                ipvlan1=$ipvlan1
        	done
		echo ""
		
		until [[ ${maskvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
        	do
                echo "Saisissez votre Masque pour ce VLAN :"
                read maskvlan1
                maskvlan1=$maskvlan1
        	done
		echo ""

		until [[ ${passlvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
        	do
                echo "Saisissez votre Passerelle pour ce VLAN :"
                read passlvlan1
                passlvlan1=$passlvlan1
        	done
		echo ""

		
		########### Confirmation 2 ###########

		echo "------------------------------------------------------------------------------------------------------"
		echo "Voici tous les paramètres entrés :"
		echo "IP pincipale : "
		echo "IP : " $ip1
		echo "Masque : "$mask
		echo "Passerelle effective : "$passl
		echo "DNS : "$dns
		echo " "

		echo "IP Vlanisé :"
		echo "Carte (n° VLAN): "$nvlan1
		echo "IP : "$ipvlan1
		echo "Masque : "$maskvlan1
		echo "Passerelle : "$passlvlan1
		echo ""
		echo "Confirmer ?"
		echo ""		

		LISTE=("[o] Oui" "[n] Non (Fermera le programme sans enregistrer)")  # liste de choix disponibles
		select CHOIX in "${LISTE[@]}" ; do
    			case $REPLY in
        			1|o|O)
        			echo "Paramètres ci-dessus validés"
				echo "L'IrisBox va redémarrer dans 30 secondes. Veuillez patienter"
		                sleep 30
                		echo "Redémarrage"
				break
        			;;
        			2|n|N)
        			exit
        			break
        			;;
    			esac
		done
		break

	elif [[ $i = "2 IP supplémentaires" ]]; then
                echo ""

                until [[ ${nvlan1} =~ ([1-9]?[0-9]?[0-9]) ]];
                do
                echo "Numéro du PREMIER VLAN :"
                read nvlan1
                nvlan1=eth0.$nvlan1
                #echo $nvlan1
                echo ""
                done

                until [[ ${ipvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                do
                echo "Saisissez votre IP pour ce premier VLAN :"
                read ipvlan1
                ipvlan1=$ipvlan1
                done
                echo ""

                until [[ ${maskvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                do
                echo "Saisissez votre Masque pour ce premier VLAN :"
                read maskvlan1
                maskvlan1=$maskvlan1
                done
                echo ""

                until [[ ${passlvlan1} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                do
                echo "Saisissez votre Passerelle pour ce premier VLAN :"
                read passlvlan1
                passlvlan1=$passlvlan1
                done
                echo ""

		########### Confirmation 3 ###########

                echo "------------------------------------------------------------------------------------------------------"
                echo "Voici tous les entrés pour le PREMIER VLAN :"
                echo "IP Vlanisé :"
                echo "Carte (n° VLAN): "$nvlan1
                echo "IP : "$ipvlan1
                echo "Masque : "$maskvlan1
                echo "Passerelle : "$passlvlan1
                echo ""
                echo "Continuer avec le second VLAN ?"
                echo ""

                LISTE=("[o] Oui" "[n] Non (Fermera le programme sans enregistrer)")  # liste de choix disponibles
                select CHOIX in "${LISTE[@]}" ; do
                        case $REPLY in
                                1|o|O)
                                echo "Paramètres du premier VLAN validés"
                                echo ""
                                echo "Configuration du SECOND VLAN"
				echo ""

				until [[ ${nvlan2} =~ ([1-9]?[0-9]?[0-9]) ]];
                		do
                			echo "Numéro du SECOND VLAN :"
                			read nvlan2
                			nvlan2=eth0.$nvlan2
                			#echo $nvlan1
                			echo ""
                		done

                		until [[ ${ipvlan2} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                		do
                			echo "Saisissez votre IP pour ce second VLAN :"
                			read ipvlan2
                			ipvlan2=$ipvlan2
					echo ""
                		done
                		
                		until [[ ${maskvlan2} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                		do
                			echo "Saisissez votre Masque pour ce second VLAN :"
                			read maskvlan2
                			maskvlan2=$maskvlan2
					echo ""                		
				done
                		
                		until [[ ${passlvlan2} =~ (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?) ]];
                		do
                			echo "Saisissez votre Passerelle pour ce second VLAN :"
                			read passlvlan2
                			passlvlan2=$passlvlan2
                			echo ""
				done
                            
				 ########### Confirmation 4 ###########

                		echo "------------------------------------------------------------------------------------------------------"
                		echo "Voici tous les paramètres entrés :"
                		echo "IP pincipale : "
                		echo "IP : " $ip1
                		echo "Masque : "$mask
                		echo "Passerelle effective : "$passl
                		echo "DNS : "$dns
                		echo " "

                		echo "Première IP Vlanisée :"
                		echo "Carte (n° VLAN): "$nvlan1
                		echo "IP : "$ipvlan1
                		echo "Masque : "$maskvlan1
                		echo "Passerelle : "$passlvlan1
                		echo ""

                                echo "Seconde IP Vlanisée :"
                                echo "Carte (n° VLAN): "$nvlan2
                                echo "IP : "$ipvlan2
                                echo "Masque : "$maskvlan2
                                echo "Passerelle : "$passlvlan2
                                echo ""
                                echo "Confirmer ?"
                                echo ""


		                LISTE=("[o] Oui" "[n] Non (Fermera le programme sans enregistrer)")  # liste de choix disponibles
               			 select CHOIX in "${LISTE[@]}" ; do
                       			 case $REPLY in
                                		1|o|O)
                                		echo "Paramètres ci-dessus validés"
                                		echo "L'IrisBox va redémarrer dans 30 secondes. Veuillez patienter"
                                		sleep 30
                                		echo "Redémarrage"
                                		break
                                		;;
                                		2|n|N)
                                		exit
                                		break
                                		;;
                        		esac
                		done
				break
				;;
               	  		2|n|N)
                        	exit
                        	break
                        	;;
			esac
		done
		break

        else
                echo "Erreur"
                exit
        fi
done

exit
