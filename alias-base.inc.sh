#!/bin/bash

################################################################################
# File: alias-base.inc.sh
################################################################################

# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

shopt -s expand_aliases
# Arguments
alias nextArg='"${1}"'    # TODO Should I do this?
alias testArgs='testIntGt "$#" "0"'
alias testArgsHave='testArgsHaveHelper "$@"'
alias testArgsMatch='testArgsMatchHelper "$@"'
alias getArgs='getArgsHelper "$@"'
alias doArgsProtect='set -- "$( getArgsHelper "$@" )"'
# Usage Methods:
# - getArgs [ Gets the Argument stack, wrapping each argument in single quotes and escaping any inline single quotes with \'s ]
# - doArgsProtect [ Applies 'getArgs' to the Argument stack itself, i.e. actualluy changing it, rather than just reading and formatting it ]
alias shiftArg='shiftArgument'
alias shiftArgLast='set -- "${@:1:$(($#-1))}"'
alias shiftArgs='shiftArgumnets'
alias shiftArgument='echoDebug "${TEXT_HI_PURPLE}ShiftArgument${TEXT_HI_WHITE}:${TEXT_RESET} ${TEXT_PURPLE}Count: [${SHIFT_COUNTint}]${TEXT_RESET}" ; shift ; ((SHIFT_COUNTint++)) ; export SHIFT_COUNTint ; '
alias shiftArguments='echoDebug "${TEXT_HI_PURPLE}ShiftArguments${TEXT_HI_WHITE}:${TEXT_RESET} ${TEXT_PURPLE}Count: [${SHIFT_COUNTint}]${TEXT_RESET}" ; while read COUNTint ; do if testEmpty "${SHIFT_COUNTint}" ; then SHIFT_COUNTint="${COUNTint}" ; else SHIFT_COUNTint=$((SHIFT_COUNTint+COUNTint)) ; fi ; export SHIFT_COUNTint ; while [ "${COUNTint}" -gt "0" ] ; do EXECUTEstr="${EXECUTEstr}shift ; " ; ((COUNTint--)) ; done ; eval "${EXECUTEstr}" ; unset EXECUTEstr ; unset COUNTint ; done <<<'
alias @initialiseObject='local ARG_COUNTint ; echoDebug "${TEXT_HI_GREEN}@initialiseObject ${TEXT_GREEN}( Args[$#]: [$( getArgsHelper "$@" )],  Stack: [$( getArgsHelper "${FUNCNAME[@]}" )],  Extends: \"${EXTENDS}\" )${TEXT_RESET}"'
alias @getDebugFUNCNAMEstack='local TEMP_FUNC=( "${FUNCNAME[@]}" ) ; echoDebug "${TEXT_HI_YELLOW}$( getArray TEMP_FUNC | sed "s/TEMP_FUNC/FUNCNAME/g" )${TEXT_RESET}" ; unset TEMP_FUNC'

alias @parseObjectArguments='exec "$( @parseObjectArgumentsHelper )" \""$@"\"' # Doesn't work as need to eval to call functions
alias @parseObjectArguments='eval "$( @parseObjectArgumentsHelper )" \""$@"\"'
alias @parseObjectArguments='eval "$( @parseObjectArgumentsHelper )" "$( getArgs )"'
