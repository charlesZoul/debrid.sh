#!/bin/bash
SCRIPT="$(basename $0)"
ERROR_BASE_MSG="[\e[31mERREUR\e[0m] : %s"
ERR_NOT_FOUND=${ERROR_BASE_MSG} 
ERR_FILE_NOT_FOUND="${ERR_BASE_MSG}"
ERR_FILE_NOT_FOUND+="fichier %s introuvable"
ERR_USAGE="Usage : \n\t- %s -l\n\t- %s -f\n\t- %s -h\n\nLa première forme permet de télécharger tous les liens contenus dans le fichier %s, un lien par ligne.\n\nLa seconde forme permet de télécharger le lien passé en paramètre.\n\nLa troisième forme affiche cette aide."