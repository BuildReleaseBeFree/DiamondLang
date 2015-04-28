# Arguments, A friendly, with sensable defaults, tool for handleing command line options, without all the
# querkyness of getops and so easy to use, argument handeling is now a problem of the past!
#
# To Use:
# $ arguments -title		'The title of the app/cli tool that needs arg parsing'
# $ arguments -author		'The name/author of the tool'
# $ arguments -copyright	'Any year/message you wish appended to (c)...'
# $ argument  -short	's'	-basic		'short'		-long		'some-long-arg'	\	# Would result in -s, -short & --some-long-arg being valid
#             -value		-use		'A_VARIABLE_TO_USE_TO_STORE_THE_RESULT'		# is used if you are taking a user value and storing it in...
# e.g. this config could take:
# $ <your_tool> -s				'My value to pass to my tool'   # And would store this value in the variable named
# $ <your_tool> -short			'My value to pass to my tool'	# A_VARIABLE_TO_USE_TO_STORE_THE_RESULT for you later use
# $ <your_tool> --some-long-arg	'My value to pass to my tool'   # However, if you simply want a flag to store a boolean...
# $ argument  -short	'd' -basic		'debug'		-long		'turn-on-debug'		-use	'DEBUG'
# $ would result in any of the following setting a 'TRUE' value to the boolean variable 'DEBUG'
# $ <your_tool> -d  /  <your_tool> -debug  /  <your_tool> --turn-on-debug
# By default, all arguments are optional, if it is not, please use -r / -required / --required-option with your argument to make it so.
# e.g. you could have something such as:
# $ argument  -short	'e'	-basic		'email'		-long		'email-address' \
# 			  -value		-use		'EMAIL_ADDRESS'			-required			# Would insist on one of these:
# $ <your_tool>	-e				'some@address.com'		# Actually, it wouldn't, the bit we are missing here is a validator.
# $ <your_tool> -email			'some@address.com'		# This is where adding -v / -validate / --validate-with 'a-test-to-validate-with'
# $ <your_tool> --email-address	'some@address.com'		# becomes usefull! 

# $ flag
#
# $ 

argument ()
{
	# This seems to work just fine, even if on first run, so, lets add complexity if I find I need it
	((ARGUMENTS_COUNT++))
    local THIS_ARGUMENTS_COUNT="${ARGUMENTS_COUNT}"
	local THIS_ARGUMENT_FLAGS=''
	local THIS_ARGUMENT_VALUE='FALSE'
	local THIS_ARGUMENT_REQUIRED='-not-required-'
	local THIS_ARGUMENT_RESULT_VAR=''
	while testArgs
    do
        case ${1} in
			-s | -short | --short-option )
				# This option is for setting single character argument flags, e.g. -a / -l / -s
				shift
                setPushFront THIS_ARGUMENT_FLAGS "-${1}"
				shift
				;;
            -b | -basic | --basic-option )
				# This option of for setting basic arg. flags, e.g. -some / -basic / -flag are all basic flags, 
				# -this-is-also a basic flag, but try to avoid it, if you need to have a dash in it, you know best,
				# However, generally you would use a --long flag for such things...  (Remember, you can have as many as you want!) :)
				shift
                setPushFront THIS_ARGUMENT_FLAGS "-${1}"
				shift
				;;
			-l | -long | --long-option )
				# This is for the detailed and more verbose options, I like to have a range, so if yo have to be short and tidy
				# you can use the short flags, but when you have space, verbosity can make your script speak in a myuch more human friendly fashion.
                shift
                setPushFront THIS_ARGUMENT_FLAGS "--${1}"
				shift
				;;
			-v | -value | --store-value-from-user )
				# Using this option states that you wich to record A SINGLE value from the user to be used later 
                shift
                variableSet THIS_ARGUMENT_VALUE "TRUE"
				;;
			-r | -required | --required-argument )
				# Using this option states that this argument IS REQIUIRED and must be given to run the command
                shift
                variableSet THIS_ARGUMENT_REQUIRED "-is-required-"
				;;
			-u | -use | --use-var | --use-variable )
				# Using this option states that you wich to record A SINGLE value from the user to be used later 
                shift
                variableSet THIS_ARGUMENT_RESULT_VAR "${1}"
				shift
				;;
			-- | -values | --use-remainding-args )
				# Using this option states that you wich to record ALL REMAINING ARGUMENTS from the user to be used later 
                shift
                variableSet THIS_ARGUMENT_VALUE "ALL"
				;;
		esac
    done
    if testVariableUnused THIS_ARGUMENT_RESULT_VAR
    then
        echoError "An argument cannot be used without configuring a variable to store the result in."
        echoError "please use the [ -u | -use | --use-var | --use-variable ] flags to configure this!"
		return 1
    
    fi
    echo variableSet "ARGUMENT${ARGUMENTS_COUNT}" "ARGUMENT_FLAGS='${THIS_ARGUMENT_FLAGS}' ; ARGUMENT_REQUIRED='${THIS_ARGUMENT_REQUIRED}' ; ARGUMENT_VALUE='${THIS_ARGUMENT_VALUE}' ; ARGUMENT_RESULT_VAR='${THIS_ARGUMENT_RESULT_VAR}'" 
    variableSet "ARGUMENT${ARGUMENTS_COUNT}" "ARGUMENT_FLAGS='${THIS_ARGUMENT_FLAGS}' ; ARGUMENT_REQUIRED='${THIS_ARGUMENT_REQUIRED}' ; ARGUMENT_VALUE='${THIS_ARGUMENT_VALUE}' ; ARGUMENT_RESULT_VAR='${THIS_ARGUMENT_RESULT_VAR}'" 
}

arguments ()
{
    while testArgs
    do
        case ${1} in
            -t | -title | --the-title | --my-title | --title-of-this | --title-of-this-tool )
				shift
				export ARGUMENTS_TITLE="${1}"
				shift
				;;
            -a | -author | --the-author | --i-am | --author-of-this | --author-of-this-tool )
                shift
				export ARGUMENTS_AUTHOR="${1}"
				shift
				;;
            -c | -copyright | --copyright-year-and-notice )
                shift
				export ARGUMENTS_COPYRIGHT="${1}"
				shift
				;;
        esac
    done
}

alias argumentsParse='argumentsParseHelper "$@"'
argumentsParseHelper ()
{
	local ARGUMENTS_COUNT_POINTER="1"
    local ARGUMENT_POINTER # Pointer to the var that stores the argument

	testVariable ARGUMENTS_COUNT || echoError "I am sorry, it looks as if you have not configured the argument parser" || return 1
    while testArgs
    do
        case ${1} in
			a)
          echo
		  ;;
        esac
    done
	while testIntLe "${ARGUMENTS_COUNT_POINTER}" "${ARGUMENTS_COUNT}"
    do
		argumentParse "${ARGUMENTS_COUNT_POINTER}" "$@"
		((ARGUMENTS_COUNT_POINTER++))
    done
	unset ARGUMENTS_COUNT
}

argumentParse ()
{
    local ARGUMENTint="${1}" ; shift
    local ARGUMENTvar="ARGUMENT${ARGUMENTint}"
    local FLAG

	local ARGUMENT_FLAGS
	local ARGUMENT_REQUIRED
	local ARGUMENT_VALUE
	local ARGUMENT_RESULT_VAR

	eval "${!ARGUMENTvar}"

	echoDebug $( getVariable ARGUMENT_FLAGS )
	echoDebug $( getVariable ARGUMENT_REQUIRED )
	echoDebug $( getVariable ARGUMENT_VALUE )
	echoDebug $( getVariable ARGUMENT_RESULT_VAR )

    for FLAG in ${ARGUMENT_FLAGS}
    do
        testEq "${FLAG}" "0" 
    done
    echo "My Args: $@ My Count: $#"
}
