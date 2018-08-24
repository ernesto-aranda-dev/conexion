#!/bin/bash
# Autor: Ernesto Aranda
# Script para comprobar la conexión a internet y en caso de fallo reiniciar el equipo.
# Este script se ha de incluir en cron para que se ejecute periódicamente.
# NOTA: Hay que crear el directorio $MISLOGS en /var/log con sudo.

MISLOGS="ernie"
URL1="www.google.com"
URL2="www.yahoo.com"
FLOG="/var/log/$MISLOGS/reboots.log"

if test ! -f $FLOG
then
	fecha=`date`
	echo "$fecha : COMPROBANDO CONEXION PARA REINICIOS" > $FLOG
fi

function hayconexion () {
	ping -c 1 $1 | grep -c "0% packet loss"
}

#Comprueba URL1
ok=`hayconexion $URL1`
if test $ok -ne 1
then
	#Comprueba URL2
	sleep 10
	ok=`hayconexion $URL2`
fi

fecha=`date`
if test $ok -ne 1
then
	echo "$fecha : REBOOT" >> $FLOG
	reboot
fi
