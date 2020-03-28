#!/bin/sh
echo -e "This script will install its own ssh keys"
echo -e "If we need ssh keys to acess the server, supply them here."
MY_DIR=$PWD
cd ~/
read -e -p "Supply the location for the private remote ssh key(blank for current or none): "
[ ! -z $REPLY ] && export REMOTE_SSH_KEY="${HOME}/${REPLY}"
cd $MY_DIR