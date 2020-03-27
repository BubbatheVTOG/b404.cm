#!/bin/bash
echo "This password will be stored in \e[4m\e[1mCLEAR TEXT\e[0m in the deployment configuration file."
read -p "Remote users sudo password(mandatory)?: " 
while [ -z $REPLY ]; do
    echo -e "Value is MANDATORY!"
    read -p "Remote users sudo password(mandatory)?: " 
done
export REMOTE_PASSWD=$REPLY
