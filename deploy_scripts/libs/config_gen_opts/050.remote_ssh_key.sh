#!/bin/sh
read -e -p "Supply the location for the remote ssh key(blank for current): "
[ ! -z $REPLY ] && export REMOTE_SSH_KEY=$REPLY