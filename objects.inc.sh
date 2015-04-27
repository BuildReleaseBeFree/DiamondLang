#!/bin/bash
# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

################################################################################
# File: objects.inc.sh
################################################################################

Instance ()
{
	local OBJECT="${FUNCNAME}"
    __INSTANCE_OF__ "$@"
}

#new ()
#{
#    local INSTANTIATE_OF="${1}" ; shift
#	local INSTANTIATE_AS="${1}" ; shift
#	eval "$( getFunctionAs "Instance" "${INSTANTIATE_AS}" | \
#		sed -e "s/__INSTANCE_OF__/${INSTANTIATE_OF}/g" )"
    #testArgs && eval FUNCNAME[0]="${INSTANTIATE_AS}" ${INSTANTIATE_AS} \""\$@"\"
	#testArgs && eval FUNCNAME=( "${FUNCNAME[@]}" ) ${INSTANTIATE_AS} \""\$@"\"
	#testArgs && eval ${INSTANTIATE_AS} \""\$@"\"
#	testArgs && ${INSTANTIATE_AS} "$@"
#}

@parseObjectArgumentsHelper ()
{
	# This incarnation of the function is from the initial implementation where I would recurse up and down the object stack popping off arguments as I handled them.
	local EXECUTIONstr
#	set | grep -e ^FUNCNAME=
	# This takes the last element, not the first   local LOCAL_FUNCNAME=( "${FUNCNAME[@]:0:$((${#FUNCNAME[@]}-1))}" )
	local LOCAL_FUNCNAME=( "${FUNCNAME[@]}" )
	unset LOCAL_FUNCNAME[0]
#	set | grep -e ^LOCAL_FUNCNAME=
    @getDebugFUNCNAMEstack
    case "${LOCAL_FUNCNAME[1]}" in
        ${OBJECT_ROUTE})
            echoDebug "${TEXT_PURPLE}Case(OR):${TEXT_RESET} The ORIGINAL calling object with methods, Pass to my parent known as '${EXTENDS}'"
            echoDebug "${TEXT_PURPLE}Case(OR):${TEXT_RESET} At the moment this wont be used upon entry, only return to source if args left as it needs OBJECT_ROUTE to be set which happens at SOURCE 'Object'"
            EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='Object' OBJECT_RETURN='${LOCAL_FUNCNAME[1]}' ${EXTENDS}"
            ;;
        "Object")
            echoDebug "${TEXT_PURPLE}Case(O):${TEXT_RESET} The ROOT 'Object', instead of sending to our parent, our calling child is known as ${LOCAL_FUNCNAME[2]} [only for 'Object' have to use arrayGetNextValue after]"
            EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_RETURN}' OBJECT_RETURN='Object' ${LOCAL_FUNCNAME[2]}"
            ;;
        *)
            echoDebug "${TEXT_PURPLE}Case(ALL):${TEXT_RESET} We are either traversing up or down the object stack, lets see which..."
            if testEq "" "${OBJECT_ROUTE}"
            then
                echoDebug "${TEXT_PURPLE}Case(ALL-O):${TEXT_RESET} We are ENTERING the way to our ROOT 'Object'"
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='Object' OBJECT_RETURN='${LOCAL_FUNCNAME[1]}' ${EXTENDS}"
            elif testEq "Object" "${OBJECT_ROUTE}"
            then
                echoDebug "${TEXT_PURPLE}Case(ALL-O):${TEXT_RESET} We are ON the way to our ROOT 'Object'"
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_ROUTE}' OBJECT_RETURN='${OBJECT_RETURN}' ${EXTENDS}"
            else
                echoDebug "${TEXT_PURPLE}Case(ALL-C):${TEXT_RESET} We must be traversing BACK to our ORIGINAL calling object with methods, let-go..."
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_ROUTE}' OBJECT_RETURN='${OBJECT_RETURN}' '$( arrayGetNextValue "${LOCAL_FUNCNAME[1]}" "LOCAL_FUNCNAME" )'"
            fi
            ;;
        esac
        echoDebug "${TEXT_PURPLE}@parseObjectArguments${TEXT_HI_WHITE}:${TEXT_RESET}EXECUTIONstr='${EXECUTIONstr}'"
		# Lets output the string we want to execute via the alias @parseObjectArguments with the definition:
		# alias @parseObjectArguments='eval "$( @parseObjectArgumentsHelper )" \""$@"\"'
		echo -n "${EXECUTIONstr}"
}

@parseObjectArgumentsHelper ()
{
	# This version is where I try to ensure that I am always going TO the root object
	local EXECUTIONstr  # The string I will finaly execute
	# This takes the last element, not the first   local LOCAL_FUNCNAME=( "${FUNCNAME[@]:0:$((${#FUNCNAME[@]}-1))}" )
	local LOCAL_FUNCNAME=( "${FUNCNAME[@]:1}" )
#	unset LOCAL_FUNCNAME[0]
#   @getDebugFUNCNAMEstack
    echoDebug "${TEXT_HI_YELLOW}$( getArray FUNCNAME 1 )${TEXT_RESET}"
    echoDebug "${TEXT_HI_YELLOW}$( getArray LOCAL_FUNCNAME )${TEXT_RESET}"
	echoDebug "$( testVariableDefined OBJECT_ROUTE && echo "${TEXT_HI_YELLOW}$( getVariable OBJECT_ROUTE )${TEXT_RESET}" || echo "${TEXT_HI_RED}OBJECT_ROUTE=${TEXT_RESET}" )"
	echoDebug "$( testVariableDefined OBJECT_RETURN && echo "${TEXT_HI_YELLOW}$( getVariable OBJECT_RETURN )${TEXT_RESET}" || echo "${TEXT_HI_RED}OBJECT_RETURN=${TEXT_RESET}" )"
	echoDebug "$( testVariableDefined ARG_COUNTint && echo "${TEXT_HI_YELLOW}$( getVariable ARG_COUNTint )${TEXT_RESET}" || echo "${TEXT_HI_RED}ARG_COUNTint=${TEXT_RESET}" )"
    #echoDebug "${TEXT_HI_YELLOW}$( getArray LOCAL_FUNCNAME | sed "s/LOCAL_FUNCNAME/FUNCNAME/g" )${TEXT_RESET}"
    #echoDebug "${TEXT_HI_YELLOW}$( getArray LOCAL_FUNCNAME | sed "s/LOCAL_FUNCNAME/FUNCNAME/g" )${TEXT_RESET}"
    case "${LOCAL_FUNCNAME}" in
        ${OBJECT_ROUTE})
            #echoDebug "${TEXT_PURPLE}Case(OR):${TEXT_RESET} The ORIGINAL calling object with methods, Pass to my parent known as '${EXTENDS}'"
            #echoDebug "${TEXT_PURPLE}Case(OR):${TEXT_RESET} At the moment this wont be used upon entry, only return to source if args left as it needs OBJECT_ROUTE to be set which happens at SOURCE 'Object'"
            echoDebug "${TEXT_PURPLE}Case(OR)${TEXT_HI_WHITE}:${TEXT_RESET}The ORIGINAL calling object with methods, Pass to my parent known as '${EXTENDS}'"
            echoDebug "${TEXT_PURPLE}Case(OR)${TEXT_HI_WHITE}:${TEXT_RESET}At the moment this wont be used upon entry, only return to source if args left as it needs OBJECT_ROUTE to be set which happens at SOURCE 'Object'"
            EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='Object' OBJECT_RETURN='${LOCAL_FUNCNAME}' ${EXTENDS}"
            ;;
        "Object")
            #echoDebug "${TEXT_PURPLE}Case(O):${TEXT_RESET} The ROOT 'Object', instead of sending to our parent, we need to start recursing from our '${OBJECT_ROUTE}' again"
            echoDebug "${TEXT_PURPLE}Case(O)${TEXT_HI_WHITE}:${TEXT_RESET}The ROOT 'Object', instead of sending to our parent, we need to start recursing from our '${OBJECT_ROUTE}' again"
            #EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='Object' OBJECT_RETURN='${OBJECT_ROUTE}' ${OBJECT_ROUTE}"
            EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_ROUTE}' OBJECT_RETURN='Object' ${OBJECT_ROUTE}"
            ;;
        *)
            #echoDebug "${TEXT_PURPLE}Case(ALL):${TEXT_RESET} We are either traversing up or down the object stack, lets see which..."
            echoDebug "${TEXT_PURPLE}Case(ALL)${TEXT_HI_WHITE}:${TEXT_RESET}We are either traversing up or down the object stack, lets see which..."
            if testEq "" "${OBJECT_ROUTE}"
            then
                #echoDebug "${TEXT_PURPLE}Case(ALL-O):${TEXT_RESET} We are ENTERING the way to our ROOT 'Object'"
                echoDebug "${TEXT_PURPLE}Case(ALL-O)${TEXT_HI_WHITE}:${TEXT_RESET}We are ENTERING the way to our ROOT 'Object'"
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='Object' OBJECT_RETURN='${LOCAL_FUNCNAME}' ${EXTENDS}"
            elif testEq "Object" "${OBJECT_ROUTE}"
            then
                #echoDebug "${TEXT_PURPLE}Case(ALL-O):${TEXT_RESET} We are ON the way to our ROOT 'Object'"
                echoDebug "${TEXT_PURPLE}Case(ALL-O)${TEXT_HI_WHITE}:${TEXT_RESET}We are ON the way to our ROOT 'Object'"
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_ROUTE}' OBJECT_RETURN='${OBJECT_RETURN}' ${EXTENDS}"
            else
                #echoDebug "${TEXT_PURPLE}Case(ALL-C):${TEXT_RESET} We must be traversing BACK to our ORIGINAL calling object with methods, let-go..."
                echoDebug "${TEXT_PURPLE}Case(ALL-C)${TEXT_HI_WHITE}:${TEXT_RESET}We must be traversing BACK to our ORIGINAL calling object with methods, let-go..."
                EXECUTIONstr="ARG_COUNTint='${ARG_COUNTint}' OBJECT_ROUTE='${OBJECT_ROUTE}' OBJECT_RETURN='${OBJECT_RETURN}' '$( arrayGetNextValue "${LOCAL_FUNCNAME}" "LOCAL_FUNCNAME" )'"
            fi
            ;;
        esac
        echoDebug "${TEXT_PURPLE}@parseObjectArguments${TEXT_HI_WHITE}:${TEXT_RESET}EXECUTIONstr='${EXECUTIONstr}'"
		# Lets output the string we want to execute via the alias @parseObjectArguments with the definition:
		# alias @parseObjectArguments='eval "$( @parseObjectArgumentsHelper )" \""$@"\"'
		echo -n "${EXECUTIONstr}"
}

Object ()
{
	# If Object is being called from new, as a setter for e.g. Need that off the call stack so it stores it in a var with the right name
#	testEq "new" "${FUNCNAME[${#FUNCNAME[@]}-1]}" && unset FUNCNAME[${#FUNCNAME[@]}-1]
    @initialiseObject
	OBJECT_ROUTE="${OBJECT_RETURN}" 
	OBJECT_RETURN="Object"
#	local ARG_COUNTint  # Lets assign this as local so we keep ourselves to ourselves, then test if it has any value, if it does not...
	testStrEmpty "${ARG_COUNTint}" && ARG_COUNTint="0"  # ...it gets set to '0' now and '$#' on the loop to detect if we are in an infinate one :)
    while testArgs
    do
        echoDebug "${TEXT_HI_YELLOW}$( getArray FUNCNAME 1 )${TEXT_RESET}"
        echoDebug "${TEXT_HI_YELLOW}$( getArray LOCAL_FUNCNAME )${TEXT_RESET}"
        @DEBUG log DEBUG "${TEXT_HI_YELLOW}$( getArray FUNCNAME 1 )${TEXT_RESET}"
        @DEBUG log DEBUG "${TEXT_HI_YELLOW}$( getArray LOCAL_FUNCNAME )${TEXT_RESET}"
		echoDebug "${TEXT_PURPLE}testArgs${TEXT_HI_WHITE}:${TEXT_RESET}FUNCNAME: '${FUNCNAME}', OBJECT_ROUTE: '${OBJECT_ROUTE}'"
		echoDebug "${TEXT_GREEN}( Args[$#]: [$( getArgsHelper "$@" )],  Stack: [$( getArgsHelper "${FUNCNAME[@]}" )],  Extends: \"${EXTENDS}\" )${TEXT_RESET}"
        case "${1}" in
            =|-s|set|setValue|--setValue|--set-value)
				echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}SET VALUE${TEXT_RESET}"
                shiftArgument
                echoDebug "About to assign variable with following command:" ${OBJECT}=\""${1}"\"
                #eval ${FUNCNAME[${#FUNCNAME[@]} - 1]}=\""\${1}"\"
                eval ${OBJECT}=\""\${1}"\"
				shiftArgument
                ;;
            -g|get|getValue|--getValue|--get-value)
				echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}GET VALUE${TEXT_RESET}"
                shiftArgument
				# Need this before BASH2
                #eval echo \""\$${FUNCNAME[${#FUNCNAME[@]} - 1]}"\"
                #echo "${!FUNCNAME[${#FUNCNAME[@]} - 1]}"
                echo "${!OBJECT}"
                ;;
            new )
				echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}NEW${TEXT_RESET}"
                shiftArgument
                local INSTANTIATE_OF="${FUNCNAME[${#FUNCNAME[@]} - 1]}"
                local INSTANTIATE_AS="${1}" ; shift
                OBJECT="${INSTANCE_AS}"
				export OBJECT
	            eval "$( getFunctionAs "Instance" "${INSTANTIATE_AS}" | \
		            sed -e "s/__INSTANCE_OF__/${INSTANTIATE_OF}/g" )"
                testArgs && ${INSTANTIATE_AS} "$@"
				if testExist "${SHIFT_COUNTint}"
                then
                    shiftArguments "${SHIFT_COUNTint}"
					unset SHIFT_COUNTint
				fi
#                break 2
                ;;
            *)
				echoDebug "${TEXT_PURPLE}Case(A)${TEXT_HI_WHITE}:${TEXT_RESET}FUNCNAME: '${FUNCNAME}', OBJECT_ROUTE: '${OBJECT_ROUTE}'"
				echoDebug "${TEXT_PURPLE}Case(A.if)${TEXT_HI_WHITE}:${TEXT_RESET}Lets test to see if we are going round in circles with nothing to do... 'testEq "${ARG_COUNTint}" "$#"'"
                if testEq "${ARG_COUNTint}" "$#"
                then
					echoDebug "${TEXT_PURPLE}Case(A.if.true)${TEXT_HI_WHITE}:${TEXT_RESET}They are equal, we must be going round an infinite loop, oh dear..."
					echoError "${TEXT_PURPLE}Case(A.if.true)${TEXT_HI_WHITE}:${TEXT_RESET}Error: Infinite Loop Detected Whilst Parsing Argument Stack: Value '$@', Count '$#'"
                    #shift $#
                    shiftArguments $#
                else
					echoDebug "${TEXT_PURPLE}Case(A.if.false)${TEXT_HI_WHITE}:${TEXT_RESET}They are NOT equal, so lets set our ARG_COUNTint to '$#' for future detection..."
                    ARG_COUNTint="$#"
					#unset SHIFT_COUNTint
                    @parseObjectArguments
                    shiftArguments "${SHIFT_COUNTint}"
					unset SHIFT_COUNTint
                fi
				;;
        esac
    done
}

String ()
{
    local EXTENDS="Object"
	local SCRATCH
	@initialiseObject
#	while testArgs
#	do
    case "${1}" in
        getChrCount)
			echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}getChrCount${TEXT_RESET}"
            shiftArgument
			# Need this before BASH2
            #eval echo -n \""\$${FUNCNAME[${#FUNCNAME[@]} - 1]}"\" | wc -c | awk '{print $1}'
            echo -n "${!FUNCNAME[${#FUNCNAME[@]} - 1]}" | wc -c | awk '{print $1}'
            ;;
        getUppercase|getUpperCase|getCaseUpper)
			echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}getUpperCase${TEXT_RESET}"
            shiftArgument
			# Need this before BASH2
            #eval echo -n \""\$${FUNCNAME[${#FUNCNAME[@]} - 1]}"\" | wc -c | awk '{print $1}'
			echo "${!FUNCNAME[${#FUNCNAME[@]} - 1]}" | awk '{print toupper($0)}'
            ;;
        getLowercase|getLowerCase|getCaseLower)
			echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}getLowerCase${TEXT_RESET}"
            shiftArgument
			# Need this before BASH2
            #eval echo -n \""\$${FUNCNAME[${#FUNCNAME[@]} - 1]}"\" | wc -c | awk '{print $1}'
			echo "${!FUNCNAME[${#FUNCNAME[@]} - 1]}" | awk '{print tolower($0)}'
            ;;
		*)
            @parseObjectArguments
			;;
    esac
#    done
}

SuperString ()
{
    local EXTENDS="String"
	@initialiseObject
#	while testArgs
#	do
		case "${1}" in
			getCenter )
				echoDebug "${TEXT_HI_PURPLE}Case${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_PURPLE}getCenter${TEXT_RESET}"
				#echoCenter "${!FUNCNAME[${#FUNCNAME[@]} - 1]}"
				echoCenter "${!OBJECT}"
			    ;;
			*)
                @parseObjectArguments
				;;
		esac
#    done
}

testTypeArray ()
{
	local TESTstr="${1}" ; shift
	set -- $( declare -p ${TESTstr} 2> /dev/null )
	case ${2} in
		-a )
			return 0
			;;
	    *)
			return 1
			;;
	esac
}
