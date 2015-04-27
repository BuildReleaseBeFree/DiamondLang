#!/bin/bash

shopt -s expand_aliases

# Booleans
testBool () { local SHOPTbak="$( shopt -p )" ; shopt -s nocasematch ; case "${1}" in true|0|false|1) eval "${SHOPTbak}" return 0 ;; *) eval "${SHOPTbak}" ; return 1 ;; esac }
testBool ()
{
	# Lets back up our settings so we can restore them
	local SHOPTbak="$( shopt -p )"
	# We do not want case to be an issue
    shopt -s nocasematch
    case "${1}" in
        true|0|false|1)
            eval "${SHOPTbak}"
            return 0
            ;;
        *)
            eval "${SHOPTbak}"
            return 1
            ;;
    esac
}

testBoolTrue () { local SHOPTbak="$( shopt -p )" ; shopt -s nocasematch ; case "${1}" in true|0) eval "${SHOPTbak}" ; return 0 ;; *) eval "${SHOPTbak}" ; return 1 ;; esac }
testBoolTrue ()
{
	# Lets back up our settings so we can restore them
	local SHOPTbak="$( shopt -p )"
	# We do not want case to be an issue
    shopt -s nocasematch
    case "${1}" in
        true|0)
            eval "${SHOPTbak}"
            return 0
            ;;
        *)
            eval "${SHOPTbak}"
            return 1
            ;;
    esac
}

testBoolFalse () { local SHOPTbak="$( shopt -p )" ; shopt -s nocasematch ; case "${1}" in false|1) eval "${SHOPTbak}" ; return 0 ;; *) eval "${SHOPTbak}" ; return 1 ;; esac }
testBoolFalse ()
{
	# Lets back up our settings so we can restore them
	local SHOPTbak="$( shopt -p )"
	# We do not want case to be an issue
    shopt -s nocasematch
    case "${1}" in
        false|1)
            eval "${SHOPTbak}"
            return 0
            ;;
        *)
            eval "${SHOPTbak}"
            return 1
            ;;
    esac
}
