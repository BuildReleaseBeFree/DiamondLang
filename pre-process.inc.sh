#!/bin/bash

preProcessInit ()
{
    # This bit is to allow the working of conditional execution of code dependant of the bash version
    # as per the BASH_VERSINFO[0] (Major Bash Version) variable.  Use as follows:
    # @PREBASH2  echo "Do this only on BASH versions prior to v2"
    # @BASH2     echo "Do this only on BASH versions v2 and above"
    # Always use them in pairs, e.g. @BASH1 + @PREBASH1, @BASH4 + @PREBASH4 & @BASH + @POSIX
    alias @POSIX='# @POSIX #'
    alias @PREBASH='# @PREBASH #'
    alias @PREBASH1='# @PREBASH1 #'
    alias @PREBASH2='# @PREBASH2 #'
    alias @PREBASH3='# @PREBASH3 #'
    alias @PREBASH4='# @PREBASH4 #'
    alias @PREBASH5='# @PREBASH5 #'
    alias @BASH='# @BASH #'
    alias @BASH1='# @BASH1 #'
    alias @BASH2='# @BASH2 #'
    alias @BASH3='# @BASH3 #'
    alias @BASH4='# @BASH4 #'
    alias @BASH5='# @BASH5 #'
        case "${BASH_VERSINFO[0]}" in
        0)
            alias @BASH=''
            alias @PREBASH1=''
            alias @PREBASH2=''
            alias @PREBASH3=''
            alias @PREBASH4=''
            alias @PREBASH5=''
            ;;
        1)
            alias @BASH=''
            alias @BASH1=''
            alias @PREBASH2=''
            alias @PREBASH3=''
            alias @PREBASH4=''
            alias @PREBASH5=''
            ;;
        2)
            alias @BASH=''
            alias @BASH1=''
            alias @BASH2=''
            alias @PREBASH3=''
            alias @PREBASH4=''
            alias @PREBASH5=''
            ;;
        3)
            alias @BASH=''
            alias @BASH1=''
            alias @BASH2=''
            alias @BASH3=''
            alias @PREBASH4=''
            alias @PREBASH5=''
            ;;
        4)
            alias @BASH=''
            alias @BASH1=''
            alias @BASH2=''
            alias @BASH3=''
            alias @BASH4=''
            alias @PREBASH5=''
            ;;
        5)
            alias @BASH=''
            alias @BASH1=''
            alias @BASH2=''
            alias @BASH3=''
            alias @BASH5=''
            ;;
        *)
            alias @POSIX=''
            alias @PREBASH=''
            ;;
    esac
    # Now the logging...
    alias @FATAL='# @FATAL #'
    alias @ERROR='# @ERROR #'
    alias @WARN='# @WARN #'
    alias @INFO='# @INFO #'
    alias @DEBUG='# @DEBUG #'
    alias @TRACE0='# @TRACE0 #'
    alias @TRACE1='# @TRACE1 #'
    alias @TRACE2='# @TRACE2 #'
    alias @TRACE3='# @TRACE3 #'
    alias @TRACE4='# @TRACE4 #'
    alias @TRACE5='# @TRACE5 #'
    alias @TRACE6='# @TRACE6 #'
    alias @TRACE7='# @TRACE7 #'
    alias @TRACE8='# @TRACE8 #'
    alias @TRACE9='# @TRACE9 #'
    alias @TRACE='# @TRACE #'
    local LOG_LEVELSset='FATAL ERROR WARN INFO DEBUG TRACE0 TRACE1 TRACE2 TRACE3 TRACE4 TRACE5 TRACE6 TRACE7 TRACE8 TRACE9 TRACE'
    testVariableDefined LOG_LEVEL || local LOG_LEVEL="INFO"
    for LOG_LEVEL_TO_TESTstr in ${LOG_LEVELSset}
    do
        if testEq "${LOG_LEVEL_TO_TESTstr}" "${LOG_LEVEL}"
        then
            alias @${LOG_LEVEL_TO_TESTstr}=''
            break 2
		else
            alias @${LOG_LEVEL_TO_TESTstr}=''
        fi
    done
}

preProcessCleanup ()
{
    unalias @POSIX
    unalias @BASH
    unalias @BASH1
    unalias @BASH2
    unalias @BASH3
    unalias @BASH4
    unalias @BASH5
    unalias @PREBASH
    unalias @PREBASH1
    unalias @PREBASH2
    unalias @PREBASH3
    unalias @PREBASH4
    unalias @PREBASH5
    unalias @FATAL
    unalias @ERROR
    unalias @WARN
    unalias @INFO
    unalias @DEBUG
    unalias @TRACE0
    unalias @TRACE1
    unalias @TRACE2
    unalias @TRACE3
    unalias @TRACE4
    unalias @TRACE5
    unalias @TRACE6
    unalias @TRACE7
    unalias @TRACE8
    unalias @TRACE9
    unalias @TRACE
}
