#!/bin/bash
if test $# -lt 3
then
	echo "$0 para asunto contenido"
	exit 1
fi

FMAIL=/var/log/ernie/mail.tmp
PARA="$1"
DE="test@gmail.com"
ASUNTO="$2"
CONTENIDO="$3"

echo "To: $PARA" > $FMAIL
echo "Subject: $ASUNTO" >> $FMAIL
echo "From: $DE" >> $FMAIL
echo "" >> $FMAIL
echo "$CONTENIDO" >> $FMAIL
echo "" >> $FMAIL

sendmail -vt < $FMAIL

