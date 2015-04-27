variableSet ()
{
    eval "${1}"=\""${2}"\" ;
}

variableGet ()
{
    echo "${!1}" ;
}

setSet ()
{
	variableSet "${1}" "${2}" ;
}

setGet ()
{
	variableGet "${1}" ;
}

testSet ()
{
	testVariable "${1}" ;
}

testSetAvailiable ()
{
    testVariableAvailiable "${1}" ;
}

testSetDefined ()
{
    testVariableDefined "${1}" ;
}

testSetUnused ()
{
    testVariableUnused "${1}" ;
}

testSetUsed ()
{
    testVariableUsed "${1}" ;
}

setPushBack ()
{
	# testSetUsed "${1}" && setSet "${1}" "${2} ${!1}" || setSet "${1}" "${2}" ;
	local THE_NAME
	local ENTITY_TO_ADD
    printf -v THE_NAME '%q' "${1}" ; shift
    printf -v ENTITY_TO_ADD '%q' "${1}" ; shift
	if testSetUsed "${THE_NAME}"
    then
        setSet "${THE_NAME}" "${ENTITY_TO_ADD} ${!THE_NAME}"
    else
		setSet "${THE_NAME}" "${ENTITY_TO_ADD}"
    fi
}

setPushFront ()
{
	# testSetUsed "${1}" && setSet "${1}" "${!1} ${2}" || setSet "${1}" "${2}" ;
	local THE_NAME
	local ENTITY_TO_ADD
    printf -v THE_NAME '%q' "${1}" ; shift
    printf -v ENTITY_TO_ADD '%q' "${1}" ; shift
	if testSetUsed "${THE_NAME}"
    then
        setSet "${THE_NAME}" "${!THE_NAME} ${ENTITY_TO_ADD}"
    else
		setSet "${THE_NAME}" "${ENTITY_TO_ADD}"
    fi
}

setPopBack ()
{
	local SET_NAME="${1}" ; shift
	if testSetUsed "${SET_NAME}"
    then
        set -- $( setGet "${SET_NAME}" )
        echo "${1}"
        shift
		setSet "${SET_NAME}" "$*"
    fi
}

setPopFront ()
{
	local SET_NAME="${1}" ; shift
	if testSetUsed "${SET_NAME}"
    then
        set -- $( setGet "${SET_NAME}" )
		@BASH3    echo "${!#}"
        #@PREBASH3 echo "${*: -1:1}"
        @PREBASH3 echo "${@:$#}"
        shiftArgLast
		setSet "${SET_NAME}" "$*"
    fi
}

setPeekBack ()
{
	local SET_NAME="${1}" ; shift
	if testSetUsed "${SET_NAME}"
    then
        set -- $( setGet "${SET_NAME}" )
        echo "${1}"
    fi
}

setPeekFront ()
{
	local SET_NAME="${1}" ; shift
	if testSetUsed "${SET_NAME}"
    then
        set -- $( setGet "${SET_NAME}" )
		@BASH3    echo "${!#}"
        #@PREBASH3 echo "${*: -1:1}"
        @PREBASH3 echo "${@:$#}"
    fi
}
