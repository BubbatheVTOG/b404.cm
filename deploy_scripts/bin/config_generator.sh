#!/bin/sh

if [ ! -f $DEPLOYMENT_FILE ]; then
    print_center "No previous deployment found. Let's make one together."
else
    clear
fi

print_center ""
print_deployment_creator_banner
print_center ""
print_center "This is a guide to help us generate a deployment configuration."
print_center "We can always re-run this guide again in the future to"
print_center "generate a different deployment configuration."
print_center ""

for CONFIG_OPT in $(ls $CONFIG_OPTS_DIR/*.sh); do
    echo ""
    source $CONFIG_OPT
done

# Remote address
[ ! -z $FQDN ] && ADDR=$FQDN || ADDR=$IP
# Remote User
[ ! -z $REMOTE_USER ] && R_USER="ansible_user=$REMOTE_USER"
# Remote ssh key file location
[ ! -z $REMOTE_SSH_KEY ] && R_KEY="ansible_ssh_private_key_file=$REMOTE_SSH_KEY" || \
    R_PASS="ansible_password=$REMOTE_PASSWD"
# Remote user password
[ ! -z $REMOTE_PASSWD ] && R_BECOME_PASS="ansible_become_password=$REMOTE_PASSWD"


# remote user
# remote user password
# remote user ssh key file
# remote user password
ACCESS_LINE="$ADDR $R_USER $R_KEY $R_PASS $R_BECOME_PASS"

# Empty the current deployement file, if there is one, else create it.
>$DEPLOYMENT_FILE

# Deployment file creation
echo "[server]"                                              >> $DEPLOYMENT_FILE
echo $ACCESS_LINE                                            >> $DEPLOYMENT_FILE
echo -e "\n[server:vars]"                                    >> $DEPLOYMENT_FILE
[ ! -z $FQDN ] && echo "fqdn=$FQDN"                          >> $DEPLOYMENT_FILE
[ ! -z $DEV_DEPLOY ] && echo "dev_deployment=$DEV_DEPLOY"    >> $DEPLOYMENT_FILE
[ ! -z $CONTEXT_ROOT ] && echo "context_root=$CONTEXT_ROOT"  >> $DEPLOYMENT_FILE
[ ! -z $BRANCH ] && echo "branch=$BRANCH"                    >> $DEPLOYMENT_FILE
[ ! -z $ADMINER ] && echo "ship_adminer=$ADMINER"            >> $DEPLOYMENT_FILE
[ ! -z $LOGGER ] && echo "ship_logger=$LOGGER"               >> $DEPLOYMENT_FILE
[ ! -z $JWT_ISSUER ] && echo "jwt_issuer=$JWT_ISSUER"        >> $DEPLOYMENT_FILE
[ ! -z $JWT_EXPIRE_DURATION ] && echo "jwt_expire_duration=$JWT_EXPIRE_DURATION"\
    >> $DEPLOYMENT_FILE
[ ! -z $MYSQL_ROOT_PASSWORD ] && echo "mysql_root_password=$MYSQL_ROOT_PASSWORD"\
    >> $DEPLOYMENT_FILE
[ ! -z $DB_USER_NAME ] && echo "db_user_name=$DB_USER_NAME"  >> $DEPLOYMENT_FILE
[ ! -z $DB_PASSWORD ] && echo "db_password=$DB_PASSWORD"     >> $DEPLOYMENT_FILE
[ ! -z $DB_DATABASE_NAME ] && echo "db_database_name=$DB_DATABASE_NAME"\
    >> $DEPLOYMENT_FILE
[ ! -z $USER_NAME ] && echo "user=$USER_NAME"                >> $DEPLOYMENT_FILE
[ ! -z $HASHED_PASS ] && echo "user_pass=$HASED_PASS"        >> $DEPLOYMENT_FILE