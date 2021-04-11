#!/bin/bash

# V 0.1
# A simple bash script for downloading with alldebrid

# Constants used by the script :
# API_AGENT :   The name you give to this script when it connect to API
# API_BASE  :   The entry point to the api
# API_KEY   :   The key needed for using api. You can obtain it here : https://alldebrid.com/apikeys/
# FRAGMENTS :   Number of // downloads of the file

API_AGENT=""
API_BASE="http://api.alldebrid.com/v4"
API_KEY=""
TMP_JSON="tmp.json"
TMP_URL="tmp.url"
LIST_URLS="list.txt"
ERROR_LIST="error.txt"
FRAGMENTS=4

rm $ERROR_LIST $TMP_JSON $TMP_URL 

# Send formatted echo to stderr
echoerr() { echo -e "$@" 1>&2; }

#test every dl link
while read LINE; do
	curl -G --data-urlencode "link=${LINE}" "${API_BASE}/link/unlock?agent=${API_AGENT}&apikey=${API_KEY}" > ${TMP_JSON}
	#if JSON contains "error", notify error and pass to next link 
	[  $(grep -c "error" "${TMP_JSON}") -ge 1 ] && echoerr "[\033[31mERREUR\033[0m] Lien ${LINE} non géré" && continue
    #else put link into aria's list
	grep "link" "${TMP_JSON}"|cut -d':' -f2-|sed -e s/\\\\//g|sed -e s/\"//g|sed -e s/,//g >> "${TMP_URL}"
done < $LIST_URLS

# Then download each file it's possible to
while read LINE; do
	aria2c -s ${FRAGMENTS} ${LINE}
done < ${TMP_URL}