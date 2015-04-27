#!/bin/bash

################################################################################
# File: colours-util.inc.sh
################################################################################

# Yes, I know, the line above shouldn't need to be there as this can only be sourced,
# it's there to allow some editors to render the colours correctly.

# I expect: shopt -s expand_aliases
# and.. source colours-base.inc.properties

getAnsiColor16Table ()
{
	# This file echoes a bunch of color codes to the terminal to demonstrate
	# what's available. Each line is the color code of one forground color,
	# out of 17 (default + 16 escapes), followed by a test use of that color
	# on all nine background colors (default + 8 escapes).
	#
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	[ "${MASTER_HEADINGbool}" != "false" ] && COLUMNS="80" echoCenter "ANSI 16 Color Terminal Refrance Table"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	# Reset
	echo -e -n "\033[0m"
	
	local T='xYz'   # The test text
	echo "                 40m     41m     42m     43m     44m     45m     46m     47m"
	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m'
	do
		FG=${FGs// /}
		echo -en " ${FGs} \033[${FG}  ${T}  "
		for BG in 40m 41m 42m 43m 44m 45m 46m 47m
		do
			echo -en "${EINS} \033[${FG}\033[${BG}  ${T} \033[0m\033[${BG} \033[0m"
		done
		echo
	done
    echo -e "\n"
}

getAnsiColor256Table ()
{
	#
	# generates an 8 bit color table (256 colors) for reference,
	# using the ANSI CSI+SGR \033[48;5;${val}m for background and
	# \033[38;5;${val}m for text (see "ANSI Code" on Wikipedia)
	#
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	[ "${MASTER_HEADINGbool}" != "false" ] && COLUMNS="113" echoCenter "ANSI 256 Color Terminal Refrance Table"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	# Reset
	echo -e -n "\033[0m"
	
	# Lets start our heading line with a '+' prefix
	echo -n "   +  "
	# Then the numbers
	for i in {0..35}
	do
		printf "%2b " "${i}"
	done
	# Now the rows
	printf "\n\n %3b  " 0
	for i in {0..15}
	do
		echo -en "\033[48;5;${i}m  \033[m "
	done
	#for i in 16 52 88 124 160 196 232; do
	for i in {0..6}
	do
		let "i = i*36 +16"
		printf "\n\n %3b  " "${i}"
		for j in {0..35}
		do
			let "val = i+j"
			echo -en "\033[48;5;${val}m  \033[m "
		done
	done
	echo -e "\n"
}

getAnsiColorTables ()
{
	getAnsiColor16Table
	getAnsiColor256Table
}

getAnsiColor256TableCustomBackground ()
{
	# Deal with 00 padding the BACKGROUNDint to ensure size is x 3 chrs
	local BACKGROUNDint="00${1}" ; shift    # To avoid printf (problematic - intermitantly), aditional padding
	BACKGROUNDint="${BACKGROUNDint: -3}"	# ...then trim from the right, should always leave 002 032, etc..
	local SPACERstr=" "
    local WRAP_COUNTint="$((COLUMNS/6))"
	local ECHO_CONTROLstr=""
    if [ "${TRAILING_NEW_LINEbool}" != "false" ] 
	then
		local LINE_COUNTint="0"
	else
		[ -z "${LINE_COUNTint}" ] && LINE_COUNTint="0"
	fi
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	[ "${MASTER_HEADINGbool}" != "false" ] && echoCenter "ANSI 256 Color Terminal Advanced Refrance Table"
	[ "${SUB_HEADINGbool}" != "false" ] && echoCenter "Forground Colors with escape codes as text on [${BACKGROUNDint}] background"
	[ "${SUB_HEADINGbool}" != "false" ] && echo
	# Reset
	echo -e -n "\033[0m"
	# If we are running in 'inline' mode, e.g. SUB_HEADINGbool='false' then lets have the background ANSI code as a table cell [BACKGROUNDint]
	if [ "${SUB_HEADINGbool}" = "false" ]
	then
		if [ "${LINE_COUNTint}" -eq "${WRAP_COUNTint}" ]
		then
			LINE_COUNTint="0"
	    	echo -e "${ECHO_CONTROLstr}"
		fi
		((LINE_COUNTint++))
	    echo -e -n " [${BACKGROUNDint}]"
	fi
    # First lets do the forground
    for i in $( seq -f "%03g" 0 256 )
    do
        if [ "${LINE_COUNTint}" -eq "${WRAP_COUNTint}" ]
        then
            LINE_COUNTint="0"
            echo -e "${ECHO_CONTROLstr}"
        fi
        ((LINE_COUNTint++))
			# Reset and SPACERstr
            echo -e -n "\033[0m${SPACERstr}"
			# Set Background Color to 'BACKGROUNDint'
            echo -e -n "\033[48;5;${BACKGROUNDint}m"
			# Set Forground Color to 'i'
            echo -e -n "\033[38;5;${i}m"
			# Print the Value of 'i', 0 padded x 3, sace on each side
            echo -n " ${i} "
			# Reset
            echo -e -n "\033[0m"
    done
    [ "${TRAILING_NEW_LINEbool}" != "false" ] && echo -e "\n"
}

getAnsiColor256TableAdvancedForground ()
{
	local MASTER_HEADINGbool="false"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	[ "${MASTER_HEADINGbool}" != "false" ] && echoCenter "ANSI 256 Color Terminal Advanced Refrance Table"
	# Reset
	echo -e -n "\033[0m"
	getAnsiColor256TableCustomBackground "0"
	getAnsiColor256TableCustomBackground "255"
}

getAnsiColor256TableAdvancedBackground ()
{
	local SPACERstr=" "
    local WRAP_COUNTint="$((COLUMNS/18))"
    local LINE_COUNTint="0"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	[ "${MASTER_HEADINGbool}" != "false" ] && echoCenter "ANSI 256 Color Terminal Advanced Refrance Table"
	echoCenter "Background Colors with [ Default ], [ White ] + [ Black ] forground text"
	echo
	# Reset
	echo -e -n "\033[0m"
    # Now lets do the background
    for i in $( seq -f "%03g" 0 256 )
    do
        ((LINE_COUNTint++))
        if [ "${LINE_COUNTint}" -gt "${WRAP_COUNTint}" ]
        then
            LINE_COUNTint="0"
            echo
        else
            echo -e -n "\033[0m${SPACERstr}"
            echo -e -n "\033[48;5;${i}m"
            echo -n " ${i} "
            echo -e -n "\033[0m${SPACERstr}"
            echo -e -n "\033[38;5;255m"
            echo -e -n "\033[48;5;${i}m"
            echo -n " ${i} "
            echo -e -n "\033[0m${SPACERstr}"
            echo -e -n "\033[38;5;0m"
            echo -e -n "\033[48;5;${i}m"
            echo -n " ${i} "
            echo -e -n "\033[0m"
        fi
    done
    echo -e "\n"
}

getAnsiColor256TableAdvancedForground ()
{
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	[ "${MASTER_HEADINGbool}" != "false" ] && echo
	[ "${MASTER_HEADINGbool}" != "false" ] && echoCenter "ANSI 256 Color Terminal Advanced Refrance Table"
	# Reset
	echo -e -n "\033[0m"
	local MASTER_HEADINGbool="false"
	getAnsiColor256TableCustomBackground "0"
	getAnsiColor256TableCustomBackground "255"
}

getAnsiColor256TableAdvanced ()
{
	local MASTER_HEADINGbool="false"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	echoCenter "ANSI 256 Color Terminal Advanced Refrance Table"
	# Reset
	echo -e -n "\033[0m"
	getAnsiColor256TableAdvancedForground
	getAnsiColor256TableAdvancedBackground
}

getAnsiColor256TableComplete ()
{
	local MASTER_HEADINGbool="false"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	echoCenter "ANSI 256 Color Terminal Complete Refrance Table"
	# Reset
	echo -e -n "\033[0m"
    # Now lets get each of the 256 backgrounds with the range of forgrounds...
    for i in $( seq -f "%03g" 0 256 )
    do
		getAnsiColor256TableCustomBackground "${i}"
	done
}

getAnsiColor256TableContinious ()
{
	local MASTER_HEADINGbool="false"
	local SUB_HEADINGbool="false"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	echoCenter "ANSI 256 Color Terminal Continious Refrance Table"
	echo
	# Reset
	echo -e -n "\033[0m"
    # Now lets get each of the 256 backgrounds with the range of forgrounds...
    for i in $( seq -f "%03g" 0 256 )
    do
		getAnsiColor256TableCustomBackground "${i}"
	done
}

getAnsiColor256TableRainbow ()
{
	local MASTER_HEADINGbool="false"
	local SUB_HEADINGbool="false"
	local TRAILING_NEW_LINEbool="false"
	local LINE_COUNTint="0"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	echoCenter "ANSI 256 Color Terminal Continious Refrance Table"
	echoCenter "Showing complete range on forground, on complete range of backgrounds"
	echoCenter "Current background is shown as [000] at the start of each forground sequence"
	echo
	# Reset
	echo -e -n "\033[0m"
    # Now lets get each of the 256 backgrounds with the range of forgrounds...
    for i in $( seq -f "%03g" 0 256 )
    do
		getAnsiColor256TableCustomBackground "${i}"
	done
	echo -e "\n"
}

getYellow ()
{
	local COLOR_LIST="003 011 100 106 107 136 142 143 144 148 149 150 151 152 154 155 156 157 158 172 178 179 180 181 184 185 186 187 190 191 192 193 194 195 202 208 214 215 216 217 220 221 222 223 226 227 228 229 230 231"
	# Deal with 00 padding the BACKGROUNDint to ensure size is x 3 chrs
#	local BACKGROUNDint="00${1}" ; shift    # To avoid printf (problematic - intermitantly), aditional padding
#	BACKGROUNDint="${BACKGROUNDint: -3}"	# ...then trim from the right, should always leave 002 032, etc..
	local MASTER_HEADINGbool="false"
	local SUB_HEADINGbool="false"
	local TRAILING_NEW_LINEbool="false"
	local LINE_COUNTint="0"
	# Set Forground Color to White
	echo -e -n "\033[38;5;255m"
	echo
	echoCenter "ANSI 256 Color Terminal Continious Refrance Table"
	echoCenter "Showing complete range on forground, on complete range of backgrounds"
	echoCenter "Current background is shown as [000] at the start of each forground sequence"
	echo
	# Reset
	echo -e -n "\033[0m"
    # Now lets get each of the 256 backgrounds with the range of forgrounds...
    for i in ${COLOR_LIST}
    do
		getAnsiColor256TableCustomBackground "${i}"
	done
	echo -e "\n"
}
