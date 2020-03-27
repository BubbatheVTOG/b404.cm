#!/bin/bash
read -p "Remote users sudo password(mandatory)?: " 
[ ! -z $REPLY ] && return 1
export REMOTE_PASSWD=$REPLY
