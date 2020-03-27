#!/bin/bash
read -p "Remote users sudo password(mandatory)?: " 
while [ -z $REPLY ]; do
    echo -e "Value is MANDATORY!"
    read -p "Remote users sudo password(mandatory)?: " 
done
export REMOTE_PASSWD=$REPLY
