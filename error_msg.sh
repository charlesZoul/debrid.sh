#!/bin/bash
ERROR_BASE_MSG="[\e[31mERROR\e[0m] : %s"
ERR_NOT_FOUND=printf $ERROR_BASE_MSG "%%s not found"
ERR_FILE_NOT_FOUND=printf "${ERR_NOT_FOUND}" "file %%s"
ERR_USAGE=""