#!/bin/sh
read -p "What should the database root password be(blank for default)?: "
[ ! -z $REPLY ] && export MYSQL_ROOT_PASSWORD=$REPLY