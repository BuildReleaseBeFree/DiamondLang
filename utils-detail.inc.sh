#!/bin/bash
# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

################################################################################
# File: utils-detail.inc.sh
################################################################################

getWelcomeSplash ()
{
    local VERSION_TO_PRINT="$( getStringAbsoluteLength "19" "${DIAMOND_VERSION}" )"
	echo "
     \___/                                                        .     '     ,
   __/   \___/     ...sourcing Carbon Extensions into shell         _________
     \___/   \__                                                 _ /_|_____|_\ _
   __/   \___/      You now have Diamond Tipped Shell Extensions   '. \   / .'
     \___/   \__                                                     '.\ /.'
     /   \___/           v${VERSION_TO_PRINT} by James Borkowski   ,   '.'   .
         /   \                                                
    "
}

# String Tools
getStringAbsoluteLength ()
{
    local LENGHT_OF_STRINGint="${1}" ; shift
	printf "%-${LENGHT_OF_STRINGint}.${LENGHT_OF_STRINGint}s" "$*"
}

# Array Tools
arrayGetNextValue ()
{
    # ARG1: The value to find within the array
    # ARG2: The array to search for the value
    # ARG3: The variable to store the value AFTER the search value in [OPTIONAL]
    #       If ARG3 is not given, the value found AFTER will be sent to Standard Out
    local VALUE_TO_FIND="${1}" ; shift
    local ARRAY_TO_SEARCH="${1}[@]" ; shift
    local VAR_ASSIGN='%s\n' # Default behaviour, for STD_OUT with a new line
	# If we still have arguments, lets handle our optional one
    [ "$#" -gt "0" ] && VAR_ASSIGN="-v ${1} %s" ; shift
	# So we can work with an array with a fixed name (no indirect refs) Lets assign one...
    local MY_ARRAY=( "${!ARRAY_TO_SEARCH}" )
    # While we have values in our array...
    while [ "${#MY_ARRAY[@]}" -gt "0" ]
    do
        # Test if the top of our stack is what we are looking for?
        if testEq "${VALUE_TO_FIND}" "${MY_ARRAY}"
        then
            # It is, great, now lets pop that off
            MY_ARRAY=( "${MY_ARRAY[@]:1}" )
            # Return then folliwing value to the user
            printf ${VAR_ASSIGN} "${MY_ARRAY}"
            # And, break out of our itteration
            break 2
        fi
        # Get here if this parse didn't match our search, so lets pop that off the top and continue...
        MY_ARRAY=( "${MY_ARRAY[@]:1}" )
    done
}

getArray ()
{
	local ARRAY_NAMEstr="${1}" ; shift
	set | grep --color=never "^${ARRAY_NAMEstr}=("
}

getArray ()
{
	local ARRAY_OFFSETstr
	local ARRAY_ELEMENTSstr
	local ARRAY_NAMEstr="${1}" ; shift
	testArgs && ARRAY_OFFSETstr=":${1}" ; shift
	testArgs && ARRAY_ELEMENTSstr=":${1}" ; shift
	local ARRAY_GETstr="${ARRAY_NAMEstr}[@]"
	local LOCALarray=( "${!ARRAY_GETstr}" )
	eval LOCALarray=\(\ \"\$\{LOCALarray\[\@\]${ARRAY_OFFSETstr}${ARRAY_ELEMENTSstr}\}\"\ \)
	set | grep --color=never "^LOCALarray=(" | sed "s/LOCALarray/${ARRAY_NAMEstr}/g"
}

getArrays ()
{
	set | grep --color=never -e '^[a-zA-Z_][a-zA-Z0-9_]*[=][(]'
}

getVariables ()
{
	set | grep --color=never -e '^[a-zA-Z_][a-zA-Z0-9_]*[=]'
}

# Stream Tools
stream ()
{
    # sse: Sensible Stream Editor
    case "${1}" in
        delete|remove|purge)
			# Cases of removal
            shift
			case "${1}" in
                line)
                    # Dealing with individual lines
                    shift
                    testInt "${1}" && sed "${1}d"
                    ;;
		    esac
            ;;
    esac
}

# Function Tools
getFunctions () { declare -f ; }
getFunction () { testFunction "${1}" && declare -f "${1}" ; }
getFunctionAs () { testFunction "${1}" && echo "${2} ()" && getFunction "${1}" | stream delete line 1 ; }

# Variable Tools
getVariable ()
{
	local VARIABLE_NAMEstr="${1}" ; shift
	# set | grep --color=never "^${VARIABLE_NAMEstr}="
	echo "${VARIABLE_NAMEstr}=${!VARIABLE_NAMEstr}"
}

# Argument Tools
getArgsHelper ()
{
    # This is how we get the var to escape the single quotes
	# Bash style with an echo ${1//\'/\\\'} or direct (minus extra escape) ${1//\'/\'}
    local ARG_STACK="'${1//\'/\'}'" ; shift
	while testArgs
    do
        ARG_STACK="${ARG_STACK} '${1//\'/\'}'"
		shift
    done
	echo "${ARG_STACK}"
}
# Usage Methods:
# - getArgs [ Gets the Argument stack, wrapping each argument in single quotes and escaping any inline single quotes with \'s ]
# - doArgsProtect [ Applies 'getArgs' to the Argument stack itself, i.e. actualluy changing it, rather than just reading and formatting it ]

# Terminal Tools
getTermCurPos ()
{
	local CURPOS
	echo -en "\E[6n"
	read -sdR CURPOS
	CURPOS=${CURPOS#*[}
	echo "${CURPOS}"
}

setTermCurPosVars ()
{
	echo -en "\E[6n"
	read -sdR CURPOS
	export CURPOS=${CURPOS#*[}
	export POS_COLUMNS="$( echo "${CURPOS}" | awk -F';' '{print $1}' )"
	export POS_LINES="$( echo "${CURPOS}" | awk -F';' '{print $2}' )"
}

highlight ()
{
	if testArgsEq 0
    then
        # We cannot run without something to do
        echoError "You need to give me something to highlight dude..."
    elif testArgsEq 1
    then
        # We are running in simple mode
        grep --color=always -E "$*|$"
    else
        # We are gonna run in advanced mode
        echo
    fi
}

clean ()
{
	# Tool to reset the terminal, intended if playng with colors
	# or ANSI escape codes that can leave the screen in an undesired state
	echo -n "${TEXT_RESET}"
	case "${1}" in
		-c|--clear|--clear-screen)
			clear
			;;
	esac
}

# Script Tools
getScriptPath ()
{
    local SCRIPTfile="${BASH_SOURCE[0]}"                               # get the location of the script relative to the cwd
    local SCRIPTpath
    while testFileSymbolicLink "${SCRIPTfile}"                         # while the filename in ${SCRIPTfile} is a symlink
    do                                                                 # we will use dirname to strip the script file name and
        SCRIPTpath="$( cd -P "$( dirname "${SCRIPTfile}" )" && pwd )"  # cd with the -P flag that forces it to change to the 
                                                                       # physical not symbolic directory value of the symbolic link
        SCRIPTfile="$( readlink "${SCRIPTfile}" )"                 &&  
            SCRIPTfile="${SCRIPTpath}/${SCRIPTfile}"                   # if ${SCRIPTfile} is relative (doesn't begin
                                                                       # with /), resolve relative path where symlink lives
    done
    SCRIPTpath="$( cd -P "$( dirname "${SCRIPTfile}" )" && pwd )"
	echo "${SCRIPTpath}"
}

getScriptFile ()
{
    basename "${BASH_SOURCE[0]}"
}

# Echo tools
echo ()
{
    # For portability, some systems do not interpret the flags correctly
	local PRINTF_MODIFIER="%s\n"
    if testEq "-e" "${1}"
    then
        shift
		# behaves like 'echo -e "${VAR}"' ( escapes interpreted )
	    PRINTF_MODIFIER="%b\n"
        if testEq "-n" "${1}"
        then
            shift
		    # behaves like 'echo -e -n "${VAR}"' ( escapes interpreted, no new lines )
            PRINTF_MODIFIER="%b"
        fi
        @BASH3       elif testMatch "${1}" '^-ne$|^-en$'
        @PREBASH3    elif testEq "-ne" "${1}" || testEq "-en" "${1}"
    then
        shift
	    PRINTF_MODIFIER="%b"
		# behaves like 'echo -n -e "${VAR}"' ( escapes interpreted, no new lines )
    elif testEq "-n" "${1}"
    then
        shift
        # behaves like 'echo -n "${VAR}"' ( escapes NOT interpreted, no new lines )
	    PRINTF_MODIFIER="%s"
        if testEq "-e" "${1}"
        then
            shift
		    # behaves like 'echo -e -n "${VAR}"' ( escapes interpreted, no new lines )
            PRINTF_MODIFIER="%b"
        fi
    fi
	printf "${PRINTF_MODIFIER}" "$*"
}

echoCenter ()
{
	# This tool will center the text in the first arguemnt based on the COLUMNS env var, 
	# if you want a custom width to center on, prefix the command with the value you wish, e.g:
	# $ COLUMNS="80" echoCenter "Text to center on 80 COLUMN terminal"
	local TEXT_TO_OUTPUT="${1}"
	printf "%*s\n" $(((${#TEXT_TO_OUTPUT}+$COLUMNS)/2)) "${TEXT_TO_OUTPUT}"
}

echoError ()
{
    echo "$@" 1>&2
}

# This one has a breadcrumb and is in RED
echoError ()
{
        local BREAD_CRUMBstr=""
        # So we can work with an array with a fixed name (no indirect refs) Lets assign one...
        local MY_ARRAY=( "${FUNCNAME[@]}" )
        # Initialise our first value...
        [ "${#MY_ARRAY[@]}" -gt "1" ] && BREAD_CRUMBstr="${TEXT_LOW_RED}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}" && unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        # While we have values in our array...
        while [ "${#MY_ARRAY[@]}" -gt "1" ]
        do
            BREAD_CRUMBstr="${BREAD_CRUMBstr}${TEXT_LOW_RED}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}"
            unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        done
        echo "${TEXT_HI_RED}ERROR${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_LOW_RED}${BREAD_CRUMBstr}${TEXT_RESET}$@" 1>&2
}


echoDebug ()
{
    if testEq "${DEBUG}" "true"
    then
		local BREAD_CRUMBstr=""
        # So we can work with an array with a fixed name (no indirect refs) Lets assign one...
        local MY_ARRAY=( "${FUNCNAME[@]}" )
        # Initialise our first value...
        [ "${#MY_ARRAY[@]}" -gt "1" ] && BREAD_CRUMBstr="${TEXT_LOW_RED}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}" && unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        # While we have values in our array...
        while [ "${#MY_ARRAY[@]}" -gt "1" ]
        do
            BREAD_CRUMBstr="${BREAD_CRUMBstr}${TEXT_LOW_RED}${MY_ARRAY[${#MY_ARRAY[@]}-1]}${TEXT_HI_WHITE}:${TEXT_RESET}"
            unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        done
        echo "${TEXT_HI_RED}DEBUG${TEXT_HI_WHITE}:${TEXT_RESET}${TEXT_CYAN}${BREAD_CRUMBstr}${TEXT_RESET}$@"
    fi 1>&2
}

# This one has the spaces removed and HI white colons AND... Cyan shades, not RED!
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

getShellFlags ()
{
    # Lets list our flags...
	echo "shopt -p"
	shopt -p
	echo
	echo "set -o"
	set -o
}
getSetReversed ()
{
    local SET_NAMEstr="${1}" ; shift
	local SET_BUFFERstr=""
	local ITEM
	for ITEM in ${!SET_NAMEstr}
	do
        SET_BUFFERstr="${ITEM} ${SET_BUFFERstr}"
	done
	if testVariableUsed SET_BUFFERstr
    then
        echo "${SET_BUFFERstr%?}"
    else
        echo "${SET_BUFFERstr}"
    fi
}

getWordRandom ()
{
    perl -e 'open IN, "</usr/share/dict/words";rand($.) < 1 && ($n=$_) while <IN>;print $n'
}
scratch () 
{
	jot -r -c 1000000 a z | rs -g 0 6 | sort | join /usr/share/dict/words - |
	uniq
}
