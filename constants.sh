#!/bin/bash
API_AGENT=""
API_BASE="http://api.alldebrid.com/v4"
API_KEY=""
TMP_JSON="tmp.json"
TMP_URL="tmp.url"
LIST_URLS="list.txt"
ERROR_LIST="error.txt"
MSG="$(echo $0|rev|cut -d'/' -f2- |rev)"

if $(test "${LANG:0:2}" = "FR") || $(test "${LANG:0:2}" = "fr") ; then
		MSG+="error_msg.fr.sh"
	else
		MSG+="/error_msg.sh"
	fi

FRAGMENTS=4
OPSTRING="f:hl"