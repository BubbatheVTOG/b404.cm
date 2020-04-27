#!/bin/sh
read -p "What should the db users password be(blank for default)?: "
[ ! -z $REPLY ] && export DB_PASSWORD=$REPLY