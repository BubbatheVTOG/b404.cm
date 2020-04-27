#!/bin/sh
read -p "What is the database user name(blank for default)?: "
[ ! -z $REPLY ] && export DB_USER_NAME=$REPLY