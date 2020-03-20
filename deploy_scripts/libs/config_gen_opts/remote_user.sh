#!/bin/sh
read -p "What is the remote servers username(blank for current user)?: "
[ -z $REPLY ] && export REMOTE_USER=$REPLY