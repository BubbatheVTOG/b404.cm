#!/bin/sh
set -x
read -p "What is the FQDN of the server(blank for none): "
[ ! -z $REPLY ] && export FQDN=$REPLY
