#!/bin/bash

# Core Functions
shopt -s expand_aliases
alias testAlias='true ; echoDebug "Alias Echo" ; true'

a ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	b "$@"
}

b ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	c "$@"
}

c ()
{
    echoDebug "Some Debug Message"
    testAlias
    caller
	set | grep FUNCNAME=
}

echoDebug "Some Debug Message"
a "$@"



testAlias
caller
