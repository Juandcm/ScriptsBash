#!/bin/bash
#
#Comprobamos que el usuario es root.
echo " "
if [ $(whoami) != "root" ]; then
  echo "Debes ser root para correr este script."
   echo "Para entrar como root, escribe  'su'  sin las comillas."
   echo " "
  exit 1
fi
clear
echo "========================================="	>  /root/tiposervidor.txt
echo "Recogida de datos del tipo de Servidor..." 	>> /root/tiposervidor.txt
echo "=========================================" 	>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "                                          "       >> /root/tiposervidor.txt  
echo "----Información General...--------"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "Sistema Operativo.:"				>> /root/tiposervidor.txt
cat /proc/sys/kernel/ostype				>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "Versión del OS.:"					>> /root/tiposervidor.txt
cat /proc/sys/kernel/osrelease				>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "Hostname.:"					>> /root/tiposervidor.txt
cat /proc/sys/kernel/hostname				>> /root/tiposervidor.txt
echo "Domain Name.:"					>> /root/tiposervidor.txt
cat /proc/sys/kernel/domainname				>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "Tiempo vivo...-------------------"		>> /root/tiposervidor.txt
uptime 							>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "--- Fin de Información General.---"		>> /root/tiposervidor.txt
echo " 						"	>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "----Información sobre la CPU.------"		>> /root/tiposervidor.txt 
cat /proc/cpuinfo 					>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt 
echo "------FIN INFO DE LA CPU-----------"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "                                          "       >> /root/tiposervidor.txt  
echo "----Información sobre el disco-----"		>> /root/tiposervidor.txt
cat /proc/diskstats 					>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "-----fin info del disco------------"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "                                          "       >> /root/tiposervidor.txt  
echo "-Información sobre las particiones-"		>> /root/tiposervidor.txt
cat /proc/partitions					>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "-Fin info sobre las particiones----"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "                                          "       >> /root/tiposervidor.txt  
echo "---Información sobre la memoria----"		>> /root/tiposervidor.txt
cat /proc/meminfo					>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "------fin info sobre memoria-------"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt  
echo "                                          "       >> /root/tiposervidor.txt  
echo "---INFORMACIÓN DE RED-------------"		>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
dmesg | grep eth					>> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
echo "                                          "       >> /root/tiposervidor.txt
lspci 							>> /root/tiposervidor.txt
lspci -vv						>> /root/tiposervidor.txt
echo "========================================="        >> /root/tiposervidor.txt
echo "FIN Recogida de datos del tipo de Servidor..."    >> /root/tiposervidor.txt
echo "========================================="        >> /root/tiposervidor.txt  
echo "     "
echo "     "
echo " Documento guardado en /root/tiposervidor.txt"
echo " ¿Desea verlo ahora (opción 1) o Después (opción 0)?"
#Menu de Administración
while [ "$opcion" != "0" ]
  do
	#Mostramos el menú
	echo
	echo "Menú"
	echo "----"
	echo " 1. Verlo ahora. (use q para salir)"
	echo " 0. Salir."
	echo
	echo -n " Elige una opción: "
	
        read opcion
	case $opcion in
		1 )
			less /root/tiposervidor.txt
			;;
		0 )
			exit 0
			;; 
	esac
    done
 exit 0