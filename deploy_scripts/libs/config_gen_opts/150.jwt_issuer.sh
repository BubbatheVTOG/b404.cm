#!/bin/sh
read -p "Who is the issuer of the JSON web token(blank for default)?: "
[ ! -z $REPLY ] && export JWT_ISSUER=$REPLY