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

testVariableEmpty ()
{
	# Bash Notation:
	# - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
	# - ${VAR:+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
	# - 'test -z' True if the length of string is zero.
	# I need to test its not an array to remove false positives for empty arrays
    [ -z "${!1:+iAmEmpty}" ] && ! testArray "${1}" ;
}

testVariableSet ()
{
	# Bash Notation:
	# - ${!VAR}, Indirect lookup, e.g. value of var name stored in variable VAR
	# - ${VAR:+string}, VAR set, not null = string, VAR set but null = string, VAR unset = null
	# - 'test -n' True if the length of string is nonzero.  i.e. there is any value
    [ -n "${!1:+iAmSet}" ] || testArray "${1}" ;
}