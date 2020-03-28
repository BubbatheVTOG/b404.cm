#!/bin/sh
read -p "How long should JSON web tokens be valid? 
Answer must be in ISO-8601 format. (blank for defult of 8hrs)?: "
[ ! -z $REPLY ] && export JWT_EXPIRE_DURATION=$REPLY