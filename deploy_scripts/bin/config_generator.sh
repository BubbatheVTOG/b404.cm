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

CONFIG_OPTS_DIR=$PROJ_ROOT/deploy_scripts/libs/config_gen_opts
for CONFIG_OPT in $(ls $CONFIG_OPTS_DIR/*.sh); do
    source $CONFIG_OPT
done

rm $DEPLOYMENT_FILE

# Deployment file creation
echo -e "[server]"                                               >> $DEPLOYMENT_FILE
echo -e "\n[server:vars]"                                        >> $DEPLOYMENT_FILE
[ ! -z $FQDN ] && echo -e "fqdn=$FQDN\n"                         >> $DEPLOYMENT_FILE
[ ! -z $DEV_DEPLOY ] && echo -e "dev_deployment=$DEV_DEPLOY\n"   >> $DEPLOYMENT_FILE
[ ! -z $CONTEXT_ROOT ] && echo -e "context_root=$CONTEXT_ROOT\n" >> $DEPLOYMENT_FILE
[ ! -z $BRANCH ] && echo -e "branch=$BRANCH\n"                   >> $DEPLOYMENT_FILE
[ ! -z $ADMINER ] && echo -e "ship_adminer=$ADMINER\n"           >> $DEPLOYMENT_FILE
[ ! -z $LOGGER ] && echo -e "ship_logger=$LOGGER\n"              >> $DEPLOYMENT_FILE
[ ! -z $JWT_ISSUER ] && echo -e "jwt_issuer=$JWT_ISSUER\n"       >> $DEPLOYMENT_FILE
[ ! -z $JWT_EXPIRE_DURATION ] && echo -e "jwt_expire_duration=$JWT_EXPIRE_DURATION"\
    >> $DEPLOYMENT_FILE
[ ! -z $MYSQL_ROOT_PASSWORD ] && echo -e "mysql_root_password=$MYSQL_ROOT_PASSWORD"\
    >> $DEPLOYMENT_FILE
[ ! -z $DB_USER_NAME ] && echo -e "db_user_name=$DB_USER_NAME"   >> $DEPLOYMENT_FILE
[ ! -z $DB_PASSWORD ] && echo -e "db_password=$DB_PASSWORD"      >> $DEPLOYMENT_FILE
[ ! -z $DB_DATABASE_NAME] && echo -e "db_database_name=$DB_DATABASE_NAME"\
    >> $DEPLOYMENT_FILE
[ ! -z $REMOTE_USER ] && echo -e "user=$REMOTE_USER\n"           >> $DEPLOYMENT_FILE
[ ! -z $HASHED_PASS ] && echo -e "user_pass=$HASED_PASS\n"       >> $DEPLOYMENT_FILE