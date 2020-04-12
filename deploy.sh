#!/bin/bash

# Source these scripts for dependencies.
source $(dirname $0)/deploy_scripts/conf/set_environment.sh
source $(dirname $0)/deploy_scripts/libs/pretty_print_funcs.sh

########################
#      FUNCTIONS       #
########################

# Parse arguments.
function parse_args () {
    while (( "$#" )); do
		case $1 in
			-y|--no-confirm)
				SKIP_CONFIRM=true
				shift ;;
			-F|--no-format)
				FORMAT=false
				shift ;;
			--)
				shift ;;
			-h|--help)
				print_help
				exit 0 ;;
			*) print_help
				exit 1 ;;
		esac
    done
}

#######################
#        MAIN         #
#######################

[ ! -x $(command -v ansible) ] && \
	echo "You need Ansible to run this script." && exit 1
[ ! -x $(command -v mkpasswd) ] && \
	echo "You need 'mkpasswd' to run this script." && exit 1
[ ! -x $(command -v sshpass) ] && \
	echo "You need 'sshpass' to run this script." && exit 1

SKIP_CONFIRM=false
GO=false
SKIP_CONFIG_GEN=false

parse_args "$@"

# Clear the screen.
clear

echo -e ""
print_banner
echo -e ""

if [ -f $DEPLOYMENT_FILE ]; then
    read -p "Previous deployment inventory file found. Use this file \
for deployment?(Y/y): "
    [[ $REPLY =~ ^[Yy]$ ]] && SKIP_CONFIG_GEN=true
fi

# Load and run the configuration generator.
if ! $SKIP_CONFIG_GEN; then
    source $BIN/config_generator.sh
fi

# Let the user view/edit the configuration file.
read -p "View the configuration file(Y/y)?: " 
[[ $REPLY =~ ^[Yy]$ ]] && $EDITOR $DEPLOYMENT_FILE

# Print confimration screen.
if ! $SKIP_CONFIRM; then
    print_confirm
    pad=""
    if $FORMAT; then
		for (( i = 1; i <= $((($TERMINAL_WIDTH-15)/2)); i++)); do
			pad+=" "
		done
    fi
    read -p "${pad}Continue? "
    [[ $REPLY =~ ^[Yy]$ ]] || exit 0
fi

# Clear the screen of banners
clear

# GO!
eval "ansible-playbook -i ${DEPLOYMENT_FILE} ${PROJ_ROOT}/b404.yml"

[ $? -eq 0 ] && clear && print_center "🎉 Deployment successful! 🎉" || \
	print_center "Deployment failed...Please file a bug report here:" && \
	print_center "https://github.com/BubbatheVTOG/b404.cm/issues/new?assignees=&labels=bug&template=bug_report.md&title="