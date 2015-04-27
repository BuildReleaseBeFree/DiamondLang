#!/bin/bash

echo "Bash Version:			${BASH_VERSION}"
echo "Bash Versinfo:		${BASH_VERSINFO[@]}"
echo "Bash Versinfo [0]:	${BASH_VERSINFO[0]}"
echo "Bash Versinfo [1]:	${BASH_VERSINFO[1]}"
echo "Bash Versinfo [2]:	${BASH_VERSINFO[2]}"
echo "Bash Versinfo [3]:	${BASH_VERSINFO[3]}"
echo "Bash Versinfo [4]:	${BASH_VERSINFO[4]}"
echo "Bash Versinfo [5]:	${BASH_VERSINFO[5]}"

#BASH_VERSINFO
#BASH_VERSION

#POSIX#
#NON-POSIX#

#BASH#
#SH#

#BASH#
#BASH#
#BASH#
#BASH#
#BASH#
#BASH#

# Special Version Handeling For Script
alias '#BASH0'='#BASH0'
alias '#BASH1'='#BASH1'
alias '#BASH2'='#BASH2'
alias '#BASH3'='#BASH3'
alias '#BASH4'='#BASH4'
alias '#BASH5'='#BASH5'

case ${BASH_VERSINFO} in
    0)
        alias '#BASH0'=''
        ;;
    1)
        alias '#BASH0'=''
        alias '#BASH1'=''
        ;;
    2)
        alias '#BASH0'=''
        alias '#BASH1'=''
        alias '#BASH2'=''
        ;;
    3)
        alias '#BASH0'=''
        alias '#BASH1'=''
        alias '#BASH2'=''
        alias '#BASH3'=''
        ;;
    4)
        alias '#BASH0'=''
        alias '#BASH1'=''
        alias '#BASH2'=''
        alias '#BASH3'=''
        alias '#BASH4'=''
        ;;
     5)
        alias '#BASH0'=''
        alias '#BASH1'=''
        alias '#BASH2'=''
        alias '#BASH3'=''
        alias '#BASH4'=''
        alias '#BASH5'=''
        ;;
     *)
        echo "ERROR: Unhandled Bash Version: ${BASH_VERSINFO}"
        ;;
esac


