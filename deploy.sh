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

SKIP_CONFIRM=false
GO=false
SKIP_CONFIG_GEN=false

# Need to run this as root. Evaluate our privileges here.
# if [[ ${UID} != "0" ]]; then
# 	echo ""
# 	echo -e "YOU NEED TO RUN THIS SCRIPT AS ROOT!!!"
# 	print_help
# 	exit 1
# fi

parse_args "$@"

# Clear the screen.
clear

echo -e ""
print_banner
echo -e ""

if [ -f deployment.ini ]; then
    read -p "Previous deployment inventory file found. Use this file?(Y/y): " -n 1 -r
    echo #remove whitespace in buffer.
    test $REPLY =~ ^[Yy]$ && $SKIP_CONFIG_GEN=true
fi

# Load and run the configuration generator.
if $SKIP_CONFIG_GEN; then

fi

# 0. find if previous config
#     0.1. If previous deployment:
# 	0.1.1 print deployment conf to screen.
# 	0.1.2 Ask user if current deployment config is good.
# 	    0.1.2.1 User response is that current config is good
# 	    0.1.2.1.1 GOTO run config.
# 	    0.1.2.1.2 exit
# 	0.1.2.2 User response is that current config is bad.
# 	    0.1.2.2.1 GOTO configurator
#     0.2. if no previous deployment:
# 	0.2.1 GOTO configurator
# 1. Configurator
#     1.1 Ask user for IP/FQDN of server.
# 		1.1.1 set and export IP.
#     1.2 Ask user for remote user of server.
# 		1.2.1 set and export user of server.
#     1.3 Ask user for remote user password.
# 		1.3.1 set and export remote user passsword
#     1.4 Ask user for which branch to ship (Master,Testing, Dev).
# 		1.4.1 set and export branch value.
#     1.5 Ask user if deploy adminer and logger.
# 		1.5.1 set and export adminer and logger values.
#     1.6 Ask user if deployment is production or development.
# 		1.6.1 set and export prod value.
#     1.7 Ask user for FQDN of server.
# 		1.7.1 set and exprot FQDN value.
#     1.8 Ask user if remote user name of user to create
# 		1.8.1 User replies to create user
# 			1.8.1.1 set and export user name
# 	1.8.2 user replies to use defualt.
# 	    1.8.2.1 set and export default user name.
#     1.9 Ask user if remote user password or default.
# 		1.9.1 User decides to provide password.
# 		1.9.1 set and export default password.
# 	1.9.2 User provides password.
# 	    1.9.2.1 hash the input
# 	    1.9.2.1 set and export user password.
# 2.0 Generate inventory.ini
# 2. Run
# 3. Generate config documentation.





# Print confimration screen.
if ! $SKIP_CONFIRM; then
    print_confirm
    pad=""
    if $FORMAT; then
	for (( i = 1; i <= $((($TERMINAL_WIDTH-15)/2)); i++)); do
	    pad+=" "
	done
    fi
    read -p "${pad}Continue? " -n 1 -r
    echo #remove whitespace in buffer.
    if [[ $REPLY =~ ^[Yy]$ ]]; then
		GO=true
    else
	exit 1
    fi
else
    GO=true
fi

# Clear the screen of banners
clear

# GO!!!!
stages=$(ls -d $roles_dir*/)
for stage in $stages; do
    cd ${stage}
    source task.sh
    pre
    task
    post
    if $VERIFY_ALL; then
	verify
    fi
    cd ${MY_DIR}
done
