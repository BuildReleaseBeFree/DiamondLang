#!/bin/bash
testThing ()
{
	declare -p ${1} 
}

play ()
{
    local THING_TO_TEST="${1}" ; shift
	set -- $( declare -p "${THING_TO_TEST}" )
	echo $? $# - $@
	echo ${2}
}

reportExecution ()
{
	local RESULT="$?"
	if [ ${RESULT} = 0 ]
	then
		echo "[${TEXT_HI_GREEN}PASS${TEXT_RESET}]"
	else
		echo "[${TEXT_HI_RED}FAIL(${RESULT})${TEXT_RESET}]"
	fi
}

testTest ()
{
	local TEST_TO_TEST="${1}" ; shift
	local QUERY_TO_USE="${1}" ; shift
	echo -n "${TEST_TO_TEST}	${QUERY_TO_USE}		" | awk '{ printf "%-25s %s	", $1, $2 }'
	${TEST_TO_TEST} ${QUERY_TO_USE}
    reportExecution
}

THING_TO_TEST="${1}" ; shift

unset TEST_VAR

echo Unset
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo TEST_VAR=
TEST_VAR=
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo TEST_VAR='0123456789'
TEST_VAR='0123456789'
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo TEST_VAR='ABCDEfghij'
TEST_VAR='ABCDEfghij'
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo "TEST_VAR=( '0123456789' 'ABCDEfghij' )"
TEST_VAR=( '0123456789' 'ABCDEfghij' )
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo "TEST_VAR=( '' '' )"
TEST_VAR=( '' '' )
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo "TEST_VAR=( '' )"
TEST_VAR=( '' )
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

echo "TEST_VAR=()"
TEST_VAR=()
testTest test${THING_TO_TEST}			TEST_VAR
testTest test${THING_TO_TEST}Availiable	TEST_VAR
testTest test${THING_TO_TEST}Defined	TEST_VAR
testTest test${THING_TO_TEST}Set		TEST_VAR
testTest test${THING_TO_TEST}Empty		TEST_VAR

