#!/bin/bash

# Core Functions
shopt -s expand_aliases
alias testAlias='true ; echoDebug "Alias Echo" ; true'

echoDebug ()
{
    if testEq "${DEBUG}" "true"
    then
        local BREAD_CRUMBstr=""
        # So we can work with an array with a fixed name (no indirect refs) Lets assign one...
        local MY_ARRAY=( "${FUNCNAME[@]}" )
        # Initialise our first value...
        [ "${#MY_ARRAY[@]}" -gt "1" ] && BREAD_CRUMBstr="${TEXT_LOW_CYAN}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}" && unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        # While we have values in our array...
        while [ "${#MY_ARRAY[@]}" -gt "1" ]
        do
            BREAD_CRUMBstr="${BREAD_CRUMBstr}${TEXT_LOW_CYAN}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}"
            unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        done
        echo "${TEXT_HI_CYAN}DEBUG${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_LOW_CYAN}${BREAD_CRUMBstr}${TEXT_RESET}$@"
    fi 1>&2
}

a ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	b "$@"
}

b ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	c "$@"
}

c ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	set | grep FUNCNAME=
}

echoDebug "Some Debug Message"
a "$@"



testAlias
caller
echo "NOW TEST INDIRECTION"
source ./scratch2.sh
