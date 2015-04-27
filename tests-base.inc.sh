#!/bin/bash
# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

################################################################################
# File: tests-base.inc.sh
################################################################################

# Some SUPER portable, lightweight, fun and friendly things that every terminal should have

# Generic Equality Tests
testEq () { [ "${1}" = "${2}" ] ; }
testNe () { [ "${1}" != "${2}" ] ; }

# String State Tests
testEmpty () { [ -z "${1}" ] ; } # True if the length of string is zero.
testValue () { [ -n "${1}" ] ; } # True if the length of string is nonzero/not-null/Has a value.

# Arguments
# Arg Play Pen until I decide...
shopt -s expand_aliases
alias nextArg='"${1}"'
alias testArgs='testIntGt "$#" "0"'
#alias testArgs='[ "$#" -gt "0" ]'
# Idea 1 + 2
testArgsEq () { testIntEq nextArg "$#" ; }
testArgsGt () { testIntGt nextArg "$#" ; }
testArgsLt () { testIntLt nextArg "$#" ; }
# Idea 1
testArgsEq () { testIntEq "${1}" "$#" ; }
testArgsGt () { testIntGt "${1}" "$#" ; }
testArgsLt () { testIntLt "${1}" "$#" ; }
# End of Arg play pen, now lets overide them...

# Baseline Arg Tests
testArgsEq () { [ "${1}" -eq "$#" ] ; }
testArgsNe () { [ "${1}" -ne "$#" ] ; }
testArgsLt () { [ "${1}" -lt "$#" ] ; }
testArgsLe () { [ "${1}" -le "$#" ] ; }
testArgsGt () { [ "${1}" -gt "$#" ] ; }
testArgsGe () { [ "${1}" -ge "$#" ] ; }

# Integer Tests
testInt () { [ "${1}" -eq "${1}" ] 2>/dev/null ; }  # I know this is okay with bash, to test with bourne
testIntEq () { testInt "${1}" && testInt "${2}" && [ "${1}" -eq "${2}" ] ; }
testIntNe () { testInt "${1}" && testInt "${2}" && [ "${1}" -ne "${2}" ] ; }
testIntLt () { testInt "${1}" && testInt "${2}" && [ "${1}" -lt "${2}" ] ; }
testIntLe () { testInt "${1}" && testInt "${2}" && [ "${1}" -le "${2}" ] ; }
testIntGt () { testInt "${1}" && testInt "${2}" && [ "${1}" -gt "${2}" ] ; }
testIntGe () { testInt "${1}" && testInt "${2}" && [ "${1}" -ge "${2}" ] ; }

# Boolean Tests
testBool () { case "${1}" in [Tt][Rr][Uu][Ee] | 0 | [Ff][Aa][Ll][Ss][Ee] | 1 ) return 0 ;; *) return 1 ;; esac }
testBoolTrue () { case "${1}" in [Tt][Rr][Uu][Ee] | 0 ) return 0 ;; *) return 1 ;; esac }
testBoolFalse () { case "${1}" in [Ff][Aa][Ll][Ss][Ee] | 1 ) return 0 ;; *) return 1 ;; esac }

# String Tests
testStr () { testIntEq "$#" "1" ; } # Test I am passed Qty: 1 valid string, if this fails, it means the string needs escaping
testStrEq () { testStr "${1}" && testStr "${2}" && testEq "${1}" "${2}" ; }  # TODO: Decide if/how I should test the type here...
testStrNe () { testStr "${1}" && testStr "${2}" && testNe "${1}" "${2}" ; }  # TODO: Decide if/how I should test the type here...
testStrEmpty () { testStr "${1}" && [ -z "${1}" ] ; } # True if the length of string is zero.
testStrExist () { testStr "${1}" && [ -n "${1}" ] ; } # True if the length of string is nonzero.

# File Tests
# -a file True if file exists.
testFile () { [ -a "${1}" ] ; }
# -b file True if file exists and is a block special file.
testFileBlock () { [ -b "${1}" ] ; }
# -c file True if file exists and is a character special file.
testFileChar () { [ -c "${1}" ] ; }
# -d file True if file exists and is a directory.
testFileDir () { [ -d "${1}" ] ; }
# -e file True if file exists.
testFileExists () { [ -e "${1}" ] ; }
# -f file True if file exists and is a regular file.
testFileRegular () { [ -f "${1}" ] ; }
# -g file True if file exists and its set-group-id bit is set.
testFileSetGroupId () { [ -g "${1}" ] ; }
# -u file True if file exists and its set-user-id bit is set.
testFileSetUserId () { [ -u "${1}" ] ; }
# -h file True if file exists and is a symbolic link.
testFileSymbolicLink () { [ -h "${1}" ] ; }                                     # WTF: This is there twice? -h & -L
# -k file True if file exists and its "sticky" bit is set.
testFileStickyBit () { [ -k "${1}" ] ; }
# -p file True if file exists and is a named pipe (FIFO).
testFilePipe () { [ -p "${1}" ] ; }
# -r file True if file exists and is readable.
testFileReadable () { [ -r "${1}" ] ; }
# -s file True if file exists and has a size greater than zero.
testFileSize () { [ -s "${1}" ] ; }
# -t fd True if file descriptor fd is open and refers to a terminal.
testFileTerm () { [ -t "${1}" ] ; }
# -w file True if file exists and is writable.
testFileWritable () { [ -w "${1}" ] ; }
# -x file True if file exists and is executable.
testFileExecutable () { [ -x "${1}" ] ; }
# -G file True if file exists and is owned by the effective group id.
testFileOwnedByEffectiveGroupId () { [ -G "${1}" ] ; }
# -O file True if file exists and is owned by the effective user id.
testFileOwnedByEffectiveUserId () { [ -O "${1}" ] ; }
# -L file True if file exists and is a symbolic link.
testFileSymbolicLink () { [ -L "${1}" ] ; }                                     # WTF: This is there twice? -h & -L
# -N file True if file exists and has been modified since it was last read.
testFileModifiedSinceLastRead () { [ -N "${1}" ] ; }
# -S file True if file exists and is a socket.
testFileSocket () { [ -S "${1}" ] ; }


# File Tests - Comparative
# file1 -ef file2
# True if file1 and file2 refer to the same device and inode numbers.
testFileEqualsFile () { [ "${1}" -ef "${2}" ] ; }
testFileEqFile () { testFileEqualsFile $@ ; }                                   # N.B. Need to fully test that I don't loose arg count this way...

# file1 -nt file2
# True if file1 is newer (according to modification date) than file2, or if file1 exists and file2 does not.
testFileNewerFile () { [ "${1}" -nt "${2}" ] ; }

# file1 -ot file2
# True if file1 is older than file2, or if file2 exists and file1 does not.
testFileOlderFile () { [ "${1}" -ot "${2}" ] ; }

# -o optname
# True if the shell option optname is enabled. The list of options appears in the description of the -o option to the set builtin (see Section 4.3.1 [The Set Builtin], page 53 {GNU BASH MANUAL} ).
testFileNewerFile () { [ "${1}" -nt "${2}" ] ; }

# Script Tests
testSourced () { if testEq "source" "${FUNCNAME[1]}" ; then return 0 ; else return 1 ; fi ; }

# Function Tests
testFunction () { testStrEq "function" "$( type -t "${1}" )" ; }


# Variable Tests
# -v varname is the OldSkool shell '-v' test to chekc a var but its only from bash 3-4 and so I am doing this:
# True if the shell variable varname is set (has been assigned a value).
testVariableAvailiable () { [ -z "${!1+iAmEmpty}" ] ; }
testVariableDefined () { [ -n "${!1+iAmSet}" ] ; }
testVariableUnused () { [ -z "${!1:+iAmEmpty}" ] ; }
testVariableUsed () { [ -n "${!1:+iAmSet}" ] ; }
