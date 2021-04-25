#!/bin/bash
configLang() {
	if $(test "${LANG:0:2}" = "FR") || $(test "${LANG:0:2}" = "fr") ; then
		echo "error_msg.fr.sh"
	else
		echo "error_msg.sh"
	fi
}

# Send formatted echo to stderr

echoErr() {
    CURMSG="$1"
    shift
	printf "${CURMSG}" $@ 1>&2;
}

getFiles() {
	aria2c -s ${FRAGMENTS} $1
}
