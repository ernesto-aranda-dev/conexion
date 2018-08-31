#!/bin/bash
FLOG=/var/log/ernie/temperaturas.log
MAXL=10000

HH=`date +%H`
MM=`date +%M`
ymd=`date +%y%m%d`

T5=`cat /sys/devices/virtual/thermal/thermal_zone0/temp`
grados=`expr $T5 / 1000`

lineas=`wc -l $FLOG | cut -d " " -f 1`
if test $lineas -gt $MAXL
then
	cat /dev/null > $FLOG
fi

echo "$ymd $HH:$MM $grados" >> $FLOG

