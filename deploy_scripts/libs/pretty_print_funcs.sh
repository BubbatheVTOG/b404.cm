#!/bin/bash

# Print help arguments.
# Usage:
#	print_help
function print_help () {
	echo -e "Arguments:"
	echo -e "\t-y" "\t\tSkip confirmation messages."
	echo -e "\t--no-confirm"
	echo -e "\t-F" "\t\tDisable centering of output."
	echo -e "\t--no-format"
}

# Prints char array arugment as centered text.
# Usage:
# 	print_center
function print_center () {
	if $FORMAT; then
		# Get first arg and the length of the arg.
		local raw_string=$*
		local str_len=${#raw_string}

		# Print the arg centered in term.
		local loc_pad=""
		for (( i = 1; i <= $((($TERMINAL_WIDTH-$str_len-4)/2)); i++)); do
			loc_pad+=" "
		done
		echo -e "$loc_pad$raw_string"
	else
		echo -e "$*"
	fi
}

# Print our welcome banner.
# Usage:
#	print_banner
function print_deployment_creator_banner () {

	if $FORMAT; then
		local msg_pad=""

		for (( i = 1; i <= $((($TERMINAL_WIDTH-51)/2)); i++)); do
			msg_pad+=" "
		done

		echo -e "$msg_pad\e[40m*************************************************\e[0m"
		echo -e "$msg_pad\e[40m**                                             **\e[0m"
		echo -e "$msg_pad\e[40m**         \e[33m🖥️\e[0m\e[40m   \e[4m\e[43mDEPLOYMENT CREATOR\e[0m\e[40m  \e[33m🖥️\e[0m\e[40m           **\e[0m"
		echo -e "$msg_pad\e[40m**                                             **\e[0m"
		echo -e "$msg_pad\e[40m*************************************************\e[0m"
	else
		echo -e "*************************************************"
		echo -e "**                                             **"
		echo -e "**         \e[33m🖥️\e[0m   \e[4m\e[43mDEPLOYMENT CREATOR\e[0m\e[49m  \e[33m🖥️\e[0m           **"
		echo -e "**                                             **"
		echo -e "*************************************************"
	fi
}

# Print our welcome banner.
# Usage:
#	print_banner
function print_banner () {
	if $FORMAT && [[ $TERMINAL_WIDTH -gt 160 ]]; then
		local msg_pad=""

		for (( i = 1; i <= $((($TERMINAL_WIDTH-160)/2)); i++)); do
			msg_pad+=" "
		done

		cat $PROJ_ROOT/deploy_scripts/libs/ascii-art.ans | while read LINE; do
			echo -e "$msg_pad$LINE"
		done
	else
		echo -e "*************************************************"
		echo -e "**                                             **"
		echo -e "**          \e[33m🖥️\e[0m      \e[97m\e[40mblink-\e[0m\e[97m\e[101m4\e[0m\e[103m0\e[0m\e[102m4\e[0m     \e[33m🖥️\e[0m             **"
		echo -e "**                                             **"
		echo -e "*************************************************"
	fi
}

# Print a confirmation screen.
# Usage:
#	print_confirm
function print_confirm () {

	if $FORMAT; then
		local msg_pad=""

		for (( i = 1; i <= $((($TERMINAL_WIDTH-26)/2)); i++)); do
			msg_pad+=" "
		done

		echo -e "$msg_pad*********************"
		echo -e "$msg_pad**                 **"
		echo -e "$msg_pad**     \e[41;5mDEPLOY??\e[0m    **"
		echo -e "$msg_pad**      (Y/n)      **"
		echo -e "$msg_pad**                 **"
		echo -e "$msg_pad*********************"
	else
		echo -e "*********************"
		echo -e "**                 **"
		echo -e "**     \e[41;5mDEPLOY??\e[0m    **"
		echo -e "**      (Y/n)      **"
		echo -e "**                 **"
		echo -e "*********************"

	fi
}

# Prints a banner with text centered in it.
# Usage:
#	print_role_banner
function print_role_banner () {
	echo ""

	# Print `#` in green for term len
	printf "\e[42m%`tput cols`s\e[0m"|tr ' ' '#'
	print_center "$@"
	# Print `#` in green for term len
	printf "\e[42m%`tput cols`s\e[0m"|tr ' ' '#'
	echo ""
}

# Print success or fail
# Usage:
# 	print_ret_res "<return code>" "<message>"
function print_ret_res () {
	if [ $1 == 0 ] ; then
		echo -e "[  \e[32mOK\e[0m  ] -- $2"
	else
		echo -e "[ \e[31mFAIL\e[0m ] -- $2"
	fi
}