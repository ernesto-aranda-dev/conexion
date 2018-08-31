#!/bin/bash
#Incluir en crontab:
#0,20,40 * * * * /home/pi/Bash/conexion.sh

URL1="www.google.com"
URL2="www.yahoo.com"
MISLOGS=ernie
FLOG=/var/log/$MISLOGS/reboots.log
MAILSH=/home/pi/Bash/mail.sh
MD=/opt/sensors/config.json
CTL=`grep email /opt/sensors/config.json | cut -d "\"" -f 4 | cut -d "@" -f 1`

if test ! -f $FLOG
then
	fecha=`date`
	echo "$fecha : COMPROBANDO CONEXION PARA REINICIOS" > $FLOG
fi

function hayconexion () {
ping -c 1 $1 | grep -c "0% packet loss"
}

#URL1
ok=`hayconexion $URL1`
if test $ok -ne 1
then
	#URL2
	sleep 300
	ok=`hayconexion $URL2`
fi
fecha=`date`
if test $ok -ne 1
then
	echo "$fecha : REBOOT" >> $FLOG
	$MAILSH "earanda@coit.es" "NO CONECTA" "$CTL: No se consigue conectar"
	#reboot
fi

