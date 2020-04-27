#!/bin/sh
read -p "What should the database name be(blank for default)?: "
[ ! -z $REPLY ] && export DB_DATABASE_NAME=$REPLY