#!/bin/bash

# V 0.1
# A simple bash script for downloading with alldebrid

# Constants used by the script :
# API_AGENT :   The name you give to this script when it connect to API
# API_BASE  :   The entry point to the api
# API_KEY   :   The key needed for using api. You can obtain it here : https://alldebrid.com/apikeys/
# FRAGMENTS :   Number of // downloads of the file

source "constants.sh"
source ${MSG}
source "functions.sh"

rm $ERROR_LIST $TMP_JSON $TMP_URL 2>/dev/null


while getopts "$OPSTRING" option; do
	case "${option}" in
	h)
		echoErr "${ERR_USAGE}"  "${SCRIPT}" "${SCRIPT}" "${SCRIPT}" "${LIST_URLS}"
		exit
		;;
	f)
		if [ -e "${OPTARGS}" ]; then
			getFiles ${OPTARGS}
		else
			echoErr "${ERR_FILE_NOT_FOUND}" "${OPTARGS}"
		fi
		;;
	l)
		if [ -e ${LIST_URLS} ]; then
			#test every dl link
			while read LINE; do
				curl -G --data-urlencode "link=${LINE}" "${API_BASE}/link/unlock?agent=${API_AGENT}&apikey=${API_KEY}" > ${TMP_JSON}
				#if JSON contains "error", notify error and pass to next link 
				[  $(grep -c "error" "${TMP_JSON}") -ge 1 ] && echoErr "[\033[31mERREUR\033[0m] Lien ${LINE} non géré" && continue
				#else put link into aria's list
				grep "link" "${TMP_JSON}"|cut -d':' -f2-|sed -e s/\\\\//g|sed -e s/\"//g|sed -e s/,//g >> "${TMP_URL}"
			done < $LIST_URLS

			# Then download each file it's possible to
			while read LINE; do
				aria2c -s ${FRAGMENTS} ${LINE}
			done < ${TMP_URL}
		else
			"[\033[31mERREUR\033[0m] Fichier list.txt introuvable"
		fi
		;;
	*)
		echoErr ${ERR_USAGE}
	esac
done