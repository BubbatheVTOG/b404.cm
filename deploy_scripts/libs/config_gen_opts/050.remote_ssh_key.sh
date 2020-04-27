#!/bin/sh
echo -e "This script will install its own ssh keys."
echo -e "It \e[4m\e[1mWILL\e[0m configure the remote SSHd to \e[4m\e[1mREQUIRE\e[0m ssh keys."
echo -e "This means you will \e[4m\e[1mNOT\e[0m be able to access the server without ssh keys after the deployment runs."
read -e -p "Do we need ssh keys to access the server currently(Y/n)?: "
[[ $REPLY =~ ^[Yy]$ ]] || return 0

MY_DIR=$PWD
cd ~/
read -e -p "Supply the location for the private remote ssh key(blank for current or none): "
[ ! -z $REPLY ] && export REMOTE_SSH_KEY="${HOME}/${REPLY}"
cd $MY_DIR