#!/bin/bash

################################################################################
# File: carbon
################################################################################

# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

# Core Variables
DIAMOND_VERSION="0.0.6"
TEXT_NL=$'\n'

recordIn ()
{
    local STORE_INvar="${1}" ; shift
    printf -v "${STORE_INvar}" '%s' "$( eval "$@" )"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	eval ${STORE_INvar}=\""$( "$@" 2>&1 )"\"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	#eval ${STORE_INvar}=\""$( "$@" 2>&1 )"\"
	#eval "${STORE_INvar}='$( "$@" 2>&1 )'"
	#eval "${STORE_INvar}"=\""$( eval \""$@"\" 2>&1 )"\"
	eval "${STORE_INvar}"=\"'$( '$@' 2>&1 ; printf %s x ; )'\"
	echo -n "${!STORE_INvar}" | wc -c
	${STORE_INvar}='${!STORE_INvar%x}'
	echo -n "${!STORE_INvar}" | wc -c
	# eval "$var='$val'"
	echoDebug "Just Executed: '$@'"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	# IFS='' read -d '' "${STORE_INvar}" <<<"$( $@ ; echo -n x )"
	IFS='' read -d '' "${STORE_INvar}" <<<"$( $@ ; echo -n x )"
    eval \"'${STORE_INvar}=${!STORE_INvar%x}'\"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	# IFS='' read -d '' "${STORE_INvar}" <<<"$( $@ ; echo -n x )"
	IFS='' read -d '' "${STORE_INvar}" <<<"$( $@ ; echo -n x )"
    eval \"'${STORE_INvar}=${!STORE_INvar%x}'\"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	local BUFFER="$( "$@" ; printf %s x ; )"
	# IFS='' read -d '' "${STORE_INvar}" <<<"$( $@ ; echo -n x )"
	#"${STORE_INvar}" <<<"$( $@ ; echo -n x )"
    #eval \"'${STORE_INvar}=${!STORE_INvar%x}'\"
    printf -v "${STORE_INvar}" %s "${BUFFER%x}"
}

as ()
{
    local STORE_INvar="${1}" ; shift
	local BUFFER="$( "$@" ; printf %s x ; )"
    printf -v "${STORE_INvar}" %s "${BUFFER%x}"
}

into ()
{
    local STORE_INvar="${1}" ; shift
    # local BUFFERstr=$( cat ; echo -n x )
    # BUFFERstr=${BUFFERstr%x}
#	myVar=$(cat; echo -n x)
#	myVar=${myVar%x}
#	printf %s "$myVar"

# var=$(echo -n $'\n'; echo -n x); var="${var%x}"; echo -n "$var" # $var == "\n"
	eval ${STORE_INvar}=\""$( "$@" 2>&1 )"\"
#	eval "${STORE_INvar}='$( "$@" 2>&1 )'"
	#eval "${STORE_INvar}"=\""$( eval \""$@"\" 2>&1 )"\"
#	eval "${STORE_INvar}"=\"'$( 'cat -' 2>&1 )'\"
	#eval "${STORE_INvar}"=\"'$( cat - 2>&1 )'\"
	#eval "${STORE_INvar}"='\$\( cat \)'
#	eval "${STORE_INvar}"=\"'\$\( cat \)'\"
	# eval "$var='$val'"
	echoDebug "Just Executed: '${STORE_INvar}=\$( cat - )'"
}

asEval ()
{
    local STORE_INvar="${1}" ; shift
	eval "${STORE_INvar}"=\"'\$( '$@' 2>&1 ; printf %s x ; )'\"
	printf %s -v "${STORE_INvar}" "${!STORE_INvar%x}"
}

asDirect ()
{
    local VARIABLEptr="${1}" ; shift
	printf -v "${VARIABLEptr}" %s "$( "$@" ; )"
}

as ()
{
    local VARIABLEptr="${1}" ; shift
	printf -v "${VARIABLEptr}" %s "$( echo \""$@"\" ; printf %s x ; )"
    printf -v "${VARIABLEptr}" %s "${!VARIABLEptr%x}"
}

asif ()
{
    local VARIABLEptr="${1}" ; shift
	printf -v "${VARIABLEptr}" %s "$( cat - ; printf %s x ; )"
    printf -v "${VARIABLEptr}" %s "${!VARIABLEptr%x}"
}

into ()
{
    local STORE_INvar="${1}" ; shift
    # local BUFFERstr=$( cat ; echo -n x )
    # BUFFERstr=${BUFFERstr%x}
#	myVar=$(cat; echo -n x)
#	myVar=${myVar%x}
#	printf %s "$myVar"

# var=$(echo -n $'\n'; echo -n x); var="${var%x}"; echo -n "$var" # $var == "\n"
	#eval ${STORE_INvar}=\""$( "$@" 2>&1 )"\"
	eval "${STORE_INvar}='$( "$@" 2>&1 )'"
	#eval "${STORE_INvar}"=\""$( eval \""$@"\" 2>&1 )"\"
#	eval "${STORE_INvar}"=\"'$( 'cat -' 2>&1 )'\"
	#eval "${STORE_INvar}"=\"'$( cat - 2>&1 )'\"
	#eval "${STORE_INvar}"='\$\( cat \)'
#	eval "${STORE_INvar}"=\"'\$\( cat \)'\"
	# eval "$var='$val'"
	echoDebug "Just Executed: '${STORE_INvar}=\$( cat - )'"
}

storeIn ()
{
    local STORE_INvar="${1}" ; shift
	eval ${STORE_INvar}="$( "$@" 2>&1 )"
}

into ()
{
    local STORE_INvar="${1}" ; shift
    # local BUFFERstr=$( cat ; echo -n x )
    # BUFFERstr=${BUFFERstr%x}
#	myVar=$(cat; echo -n x)
#	myVar=${myVar%x}
#	printf %s "$myVar"

# var=$(echo -n $'\n'; echo -n x); var="${var%x}"; echo -n "$var" # $var == "\n"
	#eval ${STORE_INvar}=\""$( "$@" 2>&1 )"\"
	eval "${STORE_INvar}='$( "$@" 2>&1 )'"
	#eval "${STORE_INvar}"=\""$( eval \""$@"\" 2>&1 )"\"
#	eval "${STORE_INvar}"=\"'$( 'cat -' 2>&1 )'\"
	#eval "${STORE_INvar}"=\"'$( cat - 2>&1 )'\"
	#eval "${STORE_INvar}"='\$\( cat \)'
#	eval "${STORE_INvar}"=\"'\$\( cat \)'\"
	# eval "$var='$val'"
	echoDebug "Just Executed: '${STORE_INvar}=\$( cat - )'"
}

storeIn ()
{
    local STORE_INvar="${1}" ; shift
	printf -v "${STORE_INvar}" '%q' "$( eval '$@' 2>&1 )"
}

filter ()
{
	grep -v "$@" ;
}

count ()
{
    case "${1}" in
        lines )
			wc -l
			;;
        words )
            wc -w
			;;
        characters | chars | bytes )
			wc -c
            ;;
        * )
			echoError "Unknown Option: $@" >2
			;;
	esac | awk '{print $1}'
}

wrap ()
{
	column -c ${COLUMNS} | more ;
}

# Bash Primitive Variable Tests
testVariable ()
{
    # Test that a refrance IS a variable (not type specific, i.e. may be an array)
    declare -p "${1}" > /dev/null 2>&1 ;
}

testVariableArray ()
{
	# Test that a refrance IS an array
	local TO_TESTstr="${1}" ; shift
	set -- $( declare -p "${TO_TESTstr}" 2> /dev/null )
	# Declare output we are matching looks like:
	# declare -a ARR='([0]="a" [1]="b" [2]="c")'
	[[ "${2}" == -*a* ]] ;
}

testVariableAvailiable ()
{
    # Bash Notation:
    # - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
    # - ${VAR+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
    # - 'test -z' True if the length of string is zero.
    # I need the negative testVariable as otherwise this test falsley reports that an array variable is availiable even if taken
    # [ -z "${!1+iAmEmpty}" ] && ! testVariable ;   ### I realised that if I am using the following there is no point in the other test!
    ! testVariable ;
}

testVariableDefined ()
{
    # As opposed to normal shell test '-v' I am using this format as it both works for all cases and
    # is portable across older variants of the shell
    # Bash Notation:
    # - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
    # - ${VAR+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
    # - 'test -n' True if the length of string is nonzero.  i.e. there is any value
    [ -n "${!1+iAmSet}" ] ;
}

testVariableUnused ()
{
    # Bash Notation:
    # - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
    # - ${VAR:+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
    # - 'test -z' True if the length of string is zero.
    # I need to test its not an array to remove false positives for empty arrays
    [ -z "${!1:+iAmEmpty}" ] && ! testArray "${1}" ;
}

testVariableUsed ()
{
    # Bash Notation:
    # - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
    # - ${VAR:+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
    # - 'test -n' True if the length of string is nonzero.  i.e. there is any value
    [ -n "${!1:+iAmSet}" ] || testArray "${1}" ;
}

# Bash Primitive Array Tests
testArray ()
{
    # Test that a refrance IS an array	    
    testVariableArray "${1}"
}

echoDebug ()
{
    if testEq "${DEBUG}" "true"
    then
        local BREAD_CRUMBstr=""
        # So we can work with an array with a fixed name (no indirect refs) Lets assign one...
        local MY_ARRAY=( "${FUNCNAME[@]}" )
        # Initialise our first value...
        [ "${#MY_ARRAY[@]}" -gt "1" ] && BREAD_CRUMBstr="${MY_ARRAY[${#MY_ARRAY[@]}-1]}:" && unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        # While we have values in our array...
        while [ "${#MY_ARRAY[@]}" -gt "1" ]
        do
            BREAD_CRUMBstr="${BREAD_CRUMBstr} ${MY_ARRAY[${#MY_ARRAY[@]}-1]}:"
            unset MY_ARRAY[${#MY_ARRAY[@]}-1] # Pop the top off the stack
        done
        echo "${TEXT_HI_RED}DEBUG${TEXT_HI_WHITE}:${TEXT_RESET} ${TEXT_CYAN}${BREAD_CRUMBstr}${TEXT_RESET} $@"
    fi 1>&2
}
# This one has the spaces removed and HI white colons
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

log ()
{
    testVariableDefined LOG_LEVEL || local LOG_LEVEL="INFO"
	local LEVELset='TRACE DEBUG INFO WARN ERROR FATAL OFF'
	local LEVELset='TRACE DEBUG INFO WARN ERROR FATAL OFF'
	local LEVELset='ARRAY=([0]="TRACE" [1]="DEBUG" [2]="INFO" [3]="WARN" [4]="ERROR" [5]="FATAL" [6]="OFF")'
    local LOGstr
    case "${1}" in
		[Tt][Rr][Aa][Cc][Ee] )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]9 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE9${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]8 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE8${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]7 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE7${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]6 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE6${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]5 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE5${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]4 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE4${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]3 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE3${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]2 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE2${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]1 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE1${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Tt][Rr][Aa][Cc][Ee]0 )
            shift
			LOGstr="${TEXT_HI_GREEN}TRACE0${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
		[Dd][Ee][Bb][Uu][Gg] )
            shift
			LOGstr="${TEXT_HI_CYAN}DEBUG${TEXT_HI_WHITE}:${TEXT_LOW_CYAN}"
            ;;
		[Ii][Nn][Ff][Oo] )
            shift
			LOGstr="${TEXT_HI_BLUE}INFO${TEXT_HI_WHITE}:${TEXT_LOW_BLUE}"
            ;;
		[Ww][Aa][Rr][Nn] )
            shift
			LOGstr="${TEXT_HI_PURPLE}WARN${TEXT_HI_WHITE}:${TEXT_LOW_PURPLE}"
            ;;
		[Ee][Rr][Rr][Oo][Rr] )
            shift
			LOGstr="${TEXT_HI_RED}ERROR${TEXT_HI_WHITE}:${TEXT_LOW_RED}"
            ;;
		[Ff][Aa][Tt][Aa][Ll] )
            shift
			LOGstr="${TEXT_HI_YELLOW}FATAL${TEXT_HI_WHITE}:${TEXT_LOW_YELLOW}"
            ;;
        [Oo][Ff][Ff] )
            shift
			if testArgs
            then
                LOGstr="${TEXT_HI_GREEN}OFF${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}Loggind Disabled with Message${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            else
                LOGstr="${TEXT_HI_GREEN}OFF${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}Logging Disabled"
            fi
            export LOG_LEVEL='OFF'
            ;;
        * )
            LOGstr="${TEXT_HI_GREEN}LOG${TEXT_HI_WHITE}:${TEXT_LOW_GREEN}"
            ;;
    esac
	echo "${LOGstr}$@${TEXT_RESET}"
}

# Core Alias definitions, rest are loaded later from alias-base.inc.sh
alias testArgs='testIntGt "$#" "0"'
loadDiamondLibraryHelper ()
{
    # Expect to be called with 1 arg, the filename of a library file to source into the environment
    local LIBRARY_NAMEstr="${1}" ; shift
	local RETURNstr="source ${LIBRARY_NAMEstr} ;"
    local LIBRARYlist="$( getFunctionNames "${LIBRARY_NAMEstr}" )"
	for FUNCTION_TO_EXPORT in ${LIBRARYlist}
    do
        RETURNstr="${RETURNstr} export -f ${FUNCTION_TO_EXPORT} ;"
	done
	echo -n "${RETURNstr}"
}
#alias loadDiamondLibrary='i'

loadDiamondLibrary ()
{
    # Expect to be called with 1 arg, the filename of a library file to source into the environment
    local LIBRARY_NAMEstr="${1}" ; shift
    # Marshal in
    testFileExists "${LIBRARY_NAMEstr}" || return 1
    local LIBRARYlist="$( getFunctionNames "${LIBRARY_NAMEstr}" )"
	# Lets prepare ourselves for loading the rest of the code...
	preProcessInit
	source "${LIBRARY_NAMEstr}"
	@DEBUG echoDebug "${TEXT_PURPLE}source${TEXT_HI_WHITE}:${TEXT_RESET}${LIBRARY_NAMEstr}"
	@TRACE5 for FUNCTION_TO_EXPORT in ${LIBRARYlist}
    @TRACE5 do
    @TRACE5     export -f "${FUNCTION_TO_EXPORT}"
	@TRACE5     echoDebug "${TEXT_PURPLE}export -f${TEXT_HI_WHITE}:${TEXT_RESET}${FUNCTION_TO_EXPORT}"
	@TRACE5 done
	preProcessCleanup
}

loadDiamondLibrary ()
{
    # Expect to be called with 1 arg, the filename of a library file to source into the environment
    local LIBRARY_NAMEstr="${1}" ; shift
    # Marshal in
    testFileExists "${LIBRARY_NAMEstr}" || return 1
    local LIBRARYlist="$( getFunctionNames "${LIBRARY_NAMEstr}" )"
	# Lets prepare ourselves for loading the rest of the code...
	preProcessInit
	source "${LIBRARY_NAMEstr}"
	echoDebug "${TEXT_PURPLE}source${TEXT_HI_WHITE}:${TEXT_RESET}${LIBRARY_NAMEstr}"
	for FUNCTION_TO_EXPORT in ${LIBRARYlist}
    do
        export -f "${FUNCTION_TO_EXPORT}"
	    echoDebug "${TEXT_PURPLE}export -f${TEXT_HI_WHITE}:${TEXT_RESET}${FUNCTION_TO_EXPORT}"
	done
	preProcessCleanup
}

# Core Functions
shopt -s expand_aliases
testEq () { [ "${1}" = "${2}" ] ; } # True if there is equality
testNe () { [ "${1}" != "${2}" ] ; } # True if there is NOT equality
testEmpty () { [ -z "${1}" ] ; } # True if the length of string is zero.
testValue () { [ -n "${1}" ] ; } # True if the length of string is nonzero/not-null/Has a value.
testFileExists () { [ -e "${1}" ] ; } # True if file exists.
testDebug () { testBoolTrue "${DEBUG}" ; } # True if DEBUG (boolean) var is true
testBool () { case "${1}" in [Tt][Rr][Uu][Ee] | 0 | [Ff][Aa][Ll][Ss][Ee] | 1 ) return 0 ;; *) return 1 ;; esac } # True if any allowed boolean value
testBoolTrue () { case "${1}" in [Tt][Rr][Uu][Ee] | 0 ) return 0 ;; *) return 1 ;; esac } # True if a 'true' boolean value
testBoolFalse () { case "${1}" in [Ff][Aa][Ll][Ss][Ee] | 1 ) return 0 ;; *) return 1 ;; esac } # True if a 'false' boolean value
testFileTerm () { [ -t "${1}" ] ; } # -t fd True if file descriptor fd is open and refers to a terminal
testFileSymbolicLink () { [ -L "${1}" ] ; } # -L file True if file exists and is a symbolic link
testInt () { [ "${1}" -eq "${1}" ] 2>/dev/null ; }  # I know this is okay with bash, to test with bourne
testIntGt () { testInt "${1}" && testInt "${2}" && [ "${1}" -gt "${2}" ] ; }
testSourced () { if testEq "source" "${FUNCNAME[1]}" ; then return 0 ; else return 1 ; fi ; } # True if calling script is sourced into environment
getStringAbsoluteLength () { local LENGHT_OF_STRINGint="${1}" ; shift ; printf "%-${LENGHT_OF_STRINGint}.${LENGHT_OF_STRINGint}s" "$*" ; }
getScriptFile () { basename "${BASH_SOURCE[0]}" ; }
getScriptPath () { local SCRIPTfile="${BASH_SOURCE[0]}" ; local SCRIPTpath ; while testFileSymbolicLink "${SCRIPTfile}"
  do SCRIPTpath="$( cd -P "$( dirname "${SCRIPTfile}" )" && pwd )" ; SCRIPTfile="$( readlink "${SCRIPTfile}" )" && 
  SCRIPTfile="${SCRIPTpath}/${SCRIPTfile}" ; done ; SCRIPTpath="$( cd -P "$( dirname "${SCRIPTfile}" )" && pwd )" ; echo "${SCRIPTpath}" ; }
echoError () { echo "$*" 1>&2 ; } # Echo to STD_ERR
getFunctionNames () { cat "${1}" | grep '^[a-z_A-Z0-9]*[a-z_A-Z0-9 ]*()' | awk '{print $1}' ; }
getFunctionNames () { testArgs && cat "$@" | grep '^[a-z_A-Z0-9]*[a-z_A-Z0-9 ]*()' | awk '{print $1}' || declare -f | grep '^[a-z_A-Z0-9]*[a-z_A-Z0-9 ]*()' | awk '{print $1}' ; }
getFunctionNames () { if testArgs ; then cat "$@" ; else declare -f ; fi | grep '^[a-z_A-Z0-9]*[a-z_A-Z0-9 ]*()' | awk '{print $1}' | sed 's/()//g' ; }
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

# Core Variables
export SCRIPTpath="$( getScriptPath )"
export SCRIPTfile="$( getScriptFile )"
export DIAMOND_HOME="${SCRIPTpath}"
export DIAMOND_BIN="${DIAMOND_HOME}/bin"
export DIAMOND_LIB="${DIAMOND_HOME}/lib"

# Start by testing our execution environment...
# Are we being sourced ( . or source ... ) or is someone trying to run me?
if testSourced
then
    # Is this a person or am I being used in a script?
    if testFileTerm "0"
    then
        getWelcomeSplash
        if testDebug
        then
            echo "My Script Path is: ${SCRIPTpath}"
            echo "My Script File is: ${SCRIPTfile}"
            echo "My DIAMOND_HOME:   ${DIAMOND_HOME}"
            echo "My DIAMOND_BIN:    ${DIAMOND_BIN}"
            echo "My DIAMOND_LIB:    ${DIAMOND_LIB}"
            echo
        fi
    else
        echo -e "\nSourced into current shell, loading Bash Extension Pack...\n"
    fi
else
    echoError -e "\n\tError: Attempted Library Execution: You need to source this library to use it!\n"
	exit 1
fi


# We got to here, so, we have an absolute 'real' path, our HOME vars are setup
# and so we are ready to load the Diamond Language in its entirety...  :-)

source ${DIAMOND_HOME}/pre-process.inc.sh

# Settings / Configuration:
# =========================
# Load generic system-wide profile settings
loadDiamondLibrary ${DIAMOND_HOME}/diamondprofile
# Load any user level profile settings that are present
loadDiamondLibrary ${HOME}/.diamondprofile

# Load PreProcess Tools
loadDiamondLibrary ${DIAMOND_HOME}/pre-process.inc.sh

# The Tools:
# ==========
# Load Aliases
loadDiamondLibrary ${DIAMOND_HOME}/alias-base.inc.sh
# Load Tests
loadDiamondLibrary ${DIAMOND_HOME}/tests-base.inc.sh
loadDiamondLibrary ${DIAMOND_HOME}/tests-detail.inc.sh
# Load Utils
loadDiamondLibrary ${DIAMOND_HOME}/utils-detail.inc.sh
# Load Colours
loadDiamondLibrary ${DIAMOND_HOME}/colours-base.inc.properties
loadDiamondLibrary ${DIAMOND_HOME}/colours-util.inc.sh
# Load Object Scratch Space
loadDiamondLibrary ${DIAMOND_HOME}/objects.inc.sh
# Load Set Type Stuff
loadDiamondLibrary ${DIAMOND_HOME}/tests-set.inc.sh

# Need this to use the tags
preProcessInit
# Cleanup:
# ========
if testDebug
then
    @PREBASH1  echo "@PREBASH1"
    @BASH1     echo "@BASH1"
    @PREBASH2  echo "@PREBASH2"
    @BASH2     echo "@BASH2"
    @PREBASH3  echo "@PREBASH3"
    @BASH3     echo "@BASH3"
    @PREBASH4  echo "@PREBASH4"
    @BASH4     echo "@BASH4"
    @PREBASH5  echo "@PREBASH5"
    @BASH5     echo "@BASH5"
fi
preProcessCleanup
