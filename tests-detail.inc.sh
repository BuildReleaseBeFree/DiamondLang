#!/bin/bash

testIttr ()
{
    until testExecutionBad
    do
        for ARGUMENT
        do
           testVariableAvailiable "${ARGUMENT}"
        done
	done
}

################################################################################
# File: tests-detail.inc.sh
################################################################################

# Some SUPER portable, lightweight, fun and friendly things that every terminal should have

alias testExecGood='testExecutionGood'
alias testExecBad='testExecutionBad'

testExecutionGood ()
{
	[ "$?" -eq "0" ] ;
}

testExecutionBad ()
{
	[ "$?" -ne "0" ] ;
}

# Generic Equality Tests
testEq () 
{
    [ "${1}" = "${2}" ] ; 
}

testNe () 
{ 
    [ "${1}" != "${2}" ] ; 
}

testMatch () 
{ 
    [[ ${1} =~ ${2} ]] ; 
}


# String State Tests
testEmpty () 
{ 
    # True if the length of string is zero.
    [ -z "${1}" ] ; 
} 

testValue ()
{ 
    # True if the length of string is nonzero.  i.e. there is any value
    [ -n "${1}" ] ; 
} 


# Arguments
# Arg Play Pen until I decide...
shopt -s expand_aliases
alias nextArg='"${1}"'
alias testArgs='testIntGt "$#" "0"'
#alias testArgs='[ "$#" -gt "0" ]'
testArgsEq () 
{ 
    testIntEq nextArg "$#" ;
}

testArgsGt () 
{ 
    testIntGt nextArg "$#" ; 
}

testArgsLt () 
{ 
    testIntLt nextArg "$#" ; 
}
# End of Arg play pen, now lets overide them...

testArgsEq () 
{ 
    [ "${1}" -eq "$#" ] ; 
}

testArgsNe () 
{ 
    [ "${1}" -ne "$#" ] ; 
}

testArgsLt () 
{ 
    [ "${1}" -lt "$#" ] ; 
}

testArgsLe () 
{ 
    [ "${1}" -le "$#" ] ; 
}

testArgsGt () 
{ 
    [ "${1}" -gt "$#" ] ; 
}

testArgsGe () 
{ 
    [ "${1}" -ge "$#" ] ; 
}

testArgsHaveHelper ()
{
    # I only want to process until I find a match or a -- (arg term symbol)
	# So, I set a negative return code and correct and break when succeeding with a match
	# N.B. Requires alias definition: alias testArgsHave='testArgsHaveHelper "$@"'
	local RETURN_CODEint="1"
    local ARG_TO_FINDstr="${!#}"
    shiftArgLast
    for ARGUMENT
    do
        if testEq "${ARGUMENT}" "--"
        then
            # We have reached our terminating token, therefore will end processing
            break 2
        elif testEq "${ARGUMENT}" "${ARG_TO_FINDstr}"
        then
            # We have found the first match for our search term, lets set our return code and end processing
	        RETURN_CODEint="0"
            break 2
        fi
    done
    return "${RETURN_CODEint}"
}

testArgsMatchHelper ()
{
    # I only want to process until I find a match or a -- (arg term symbol)
	# So, I set a negative return code and correct and break when succeeding with a match
    # N.B. Requires alias definition: alias testArgsMatch='testArgsMatchHelper "$@"'
	local RETURN_CODEint="1"
    local ARG_TO_FINDstr="${!#}"
    shiftArgLast
    for ARGUMENT
    do
        if testEq "${ARGUMENT}" "--"
        then
            # We have reached our terminating token, therefore will end processing
            break 2
        elif testMatch "${ARGUMENT}" "${ARG_TO_FINDstr}"
        then
            # We have found the first match for our search term, lets set our return code and end processing
	        RETURN_CODEint="0"
            break 2
        fi
    done
    return "${RETURN_CODEint}"
}

# Integer Tests
testInt ()
{ 
    # I know this is okay with bash, to test with bourne
    [ "${1}" -eq "${1}" ] 2>/dev/null ; 
}

testIntEq () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
	[ "${1}" -eq "${2}" ] ; 
}

testIntNe () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
    [ "${1}" -ne "${2}" ] ; 
}

testIntLt () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
    [ "${1}" -lt "${2}" ] ; 
}

testIntLe () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
    [ "${1}" -le "${2}" ] ; 
}

testIntGt () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
    [ "${1}" -gt "${2}" ] ; 
}

testIntGe () 
{ 
    testInt "${1}" &&
	testInt "${2}" &&
    [ "${1}" -ge "${2}" ] ; 
}

# Booleans
testBool ()
{
    case "${1}" in
        [Tt][Rr][Uu][Ee] | 0 | [Ff][Aa][Ll][Ss][Ee] | 1 )
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

testBoolTrue ()
{
    case "${1}" in
        [Tt][Rr][Uu][Ee] | 0 )
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

testBoolFalse ()
{
    case "${1}" in
        [Ff][Aa][Ll][Ss][Ee] | 1 )
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}


# Strings
testStr () 
{ 
    # Test I am passed Qty: 1 valid string, if this fails, it means the string needs escaping
    testIntEq "$#" "1" ; 
} 

testStrEq () 
{ 
    testStr "${1}" && 
    testStr "${2}" && 
	testEq "${1}" "${2}" ; 
}

testStrNe () 
{ 
    testStr "${1}" && 
    testStr "${2}" && 
    testNe "${1}" "${2}" ; 
}

testStrEmpty () 
{ 
    # True if the length of string is zero.
    # Shouldn't need a - testStr "${1}" && - as this should surfice...
    [ -z "${1}" ] ; 
} 

testStrExist () 
{ 
    # True if the length of string is nonzero.
    # Shouldn't need a - testStr "${1}" && - as this should surfice...
    [ -n "${1}" ] ; 
} 


# File Tests
testFile () 
{
    # -a file True if file exists and is accessable in BASH4
    @BASH4		[ -a "${1}" ] ;
	# -e has to be used as a fallback, just check existence
    @PREBASH4	[ -e "${1}" ] ;
}

testFileBlock () 
{ 
    # -b file True if file exists and is a block special file.
	# POSIX.1-2008
    [ -b "${1}" ] ; 
}

testFileChar () 
{ 
    # -c file True if file exists and is a character special file.
	# POSIX.1-2008
    [ -c "${1}" ] ; 
}

testFileDir () 
{ 
    # -d file True if file exists and is a directory.
	# POSIX.1-2008
    [ -d "${1}" ] ; 
}

testFileExists () 
{ 
    # -e file True if file exists.
	# POSIX.1-2008
    [ -e "${1}" ] ; 
}

testFileRegular () 
{ 
    # -f file True if file exists and is a regular file.
	# POSIX.1-2008
    [ -f "${1}" ] ; 
}

testFileSymbolicLink () 
{
    # Both -h and -L are the 'official' tests, commenting one out 
    # until I work out if there is any difference
	# POSIX.1-2008
    # -h file True if file exists and is a symbolic link.                         # WTF: This is there twice? -h & -L
    # -L file True if file exists and is a symbolic link.                         # WTF: This is there twice? -h & -L
    # [ -h "${1}" ] ; 
    [ -L "${1}" ] ; 
}

testFileStickyBit () 
{ 
    # -k file True if file exists and its "sticky" bit is set.
	# NON-POSIX - but I think that this is in all versions of BASH and later Bourne shels so leaving as is
    [ -k "${1}" ] ; 
}

testFilePipe () 
{ 
    # -p file True if file exists and is a named pipe (FIFO).
	# POSIX.1-2008
    [ -p "${1}" ] ; 
}

testFileReadable () 
{ 
    # -r file True if file exists and is readable.
	# POSIX.1-2008
    [ -r "${1}" ] ; 
}

testFileSize () 
{ 
    # -s file True if file exists and has a size greater than zero.
	# POSIX.1-2008
    [ -s "${1}" ] ; 
}

testFileTerm () 
{ 
    # -t fd True if file descriptor fd is open and refers to a terminal.
	# POSIX.1-2008
    [ -t "${1}" ] ; 
}

testFileSetGroupId () 
{ 
    # -g file True if file exists and its set-group-id bit is set.
	# POSIX.1-2008
    [ -g "${1}" ] ; 
}

testFileSetUserId () 
{ 
    # -u file True if file exists and its set-user-id bit is set.
	# POSIX.1-2008
    [ -u "${1}" ] ; 
}

testFileWritable () 
{ 
    # -w file True if file exists and is writable.
	# POSIX.1-2008
    [ -w "${1}" ] ; 
}

testFileExecutable () 
{ 
    # -x file True if file exists and is executable.
	# POSIX.1-2008
    [ -x "${1}" ] ; 
}

testFileOwnedByEffectiveUserId () 
{ 
    # -O file True if file exists and is owned by the effective user id.
	# NON-POSIX
    [ -O "${1}" ] ; 
}

testFileOwnedByEffectiveGroupId () 
{ 
    # -G file True if file exists and is owned by the effective group id.
	# NON-POSIX - but I think that this is in all versions of BASH and later Bourne shels so leaving as is
    [ -G "${1}" ] ; 
}

testFileModifiedSinceLastRead () 
{ 
    # -N file True if file exists and has been modified since it was last read.
	# NON-POSIX
    [ -N "${1}" ] ; 
}

testFileSocket () 
{ 
    # -S file True if file exists and is a socket.
	# POSIX.1-2008
    [ -S "${1}" ] ; 
}


# File Tests - Comparative
testFileEqualsFile () 
{
    # True if file1 and file2 refer to the same device and inode numbers.
    # file1 -ef file2
    [ "${1}" -ef "${2}" ] ; 
}

testFileEqFile () 
{
    testFileEqualsFile $@ ; 
}                                   # N.B. Need to fully test that I don't loose arg count this way...

testFileNewerFile () 
{ 
    # True if file1 is newer (according to modification date) than file2, or if file1 exists and file2 does not.
    # file1 -nt file2
    [ "${1}" -nt "${2}" ] ; 
}

testFileOlderFile () 
{
    # True if file1 is older than file2, or if file2 exists and file1 does not.
    # file1 -ot file2
    [ "${1}" -ot "${2}" ] ; 
}

testFileNewerFile () 
{
    # True if the shell option optname is enabled. The list of options appears in the description of the -o option to the set builtin (see Section 4.3.1 [The Set Builtin], page 53 {GNU BASH MANUAL} ).
    # -o optname
    [ "${1}" -nt "${2}" ] ; 
}


# Bash Primitive Variable Tests
testVariable ()
{
    # Test that a refrance IS a variable (not type specific, i.e. may be an array)
    declare -p "${1}" > /dev/null 2>&1 ;
}

testVariableReadonly ()
{
    # Test that a refrance HAS the readonly flag set
	local TO_TESTstr="${1}" ; shift
	set -- $( declare -p "${TO_TESTstr}" 2> /dev/null )
    # Declare output we are matching looks like:
	# declare -r VAR="SomeText"
    [[ "${2}" == -*r* ]] ;
}

testVariableTrace ()
{
    # Test that a refrance HAS the trace flag set
	local TO_TESTstr="${1}" ; shift
	set -- $( declare -p "${TO_TESTstr}" 2> /dev/null )
    # Declare output we are matching looks like:
	# declare -t VAR="SomeText"
    [[ "${2}" == -*t* ]] ;
}

testVariableExport ()
{
    # Test that a refrance HAS the export flag set
	local TO_TESTstr="${1}" ; shift
	set -- $( declare -p "${TO_TESTstr}" 2> /dev/null )
    # Declare output we are matching looks like:
	# declare -x VAR="SomeText"
    [[ "${2}" == -*x* ]] ;
}

testVariableInteger ()
{
    # Test that a refrance IS an integer
	local TO_TESTstr="${1}" ; shift
	set -- $( declare -p "${TO_TESTstr}" 2> /dev/null )
    # Declare output we are matching looks like:
	# declare -i VAR="SomeText"
    [[ "${2}" == -*i* ]] ;
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

testArrayAvailiable ()
{ 
    testVariableAvailiable "${1}"
}

testArrayDefined ()
{ 
    # testArray && testVariableDefined "${1}"    ### No need for both as testArray covers the test
    testArray "${1}"
}

testArraySet ()
{ 
    testArray "${1}" 								&& 
        local -a 'TESTarray=("${!'"${1}"'[@]}")' 	&&
        testIntGt "${#TESTarray[*]}" "0"
}

testArrayEmpty ()
{ 
    testArray "${1}" 								&& 
        local -a 'TESTarray=("${!'"${1}"'[@]}")' 	&&
        testIntEq "${#TESTarray[*]}" "0"
}

# Function Tests
testFunction () 
{
    testStrEq "function" "$( type -t "${1}" )" ; 
}

# Script Tests
testSourced ()
{
    # To test if a script, such as this one, is sourced or executed
    if testEq "source" "${FUNCNAME[1]}"
    then
        if testEq "-v" "${1}" || testEq "--verbose" "${1}"
        then
            echo "I am being sourced, this filename is ${BASH_SOURCE[0]} and my caller script/shell name was ${0}"
        fi
        return 0
    else
        if testEq "-v" "${1}" || testEq "--verbose" "${1}"
        then
          echo "I am not being sourced, my script/shell name was ${0}"
        fi
        return 1
    fi
}

testShellOption ()
{
    [ -o ${1} ] ;
}
