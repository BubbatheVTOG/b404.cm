#!/bin/sh
read -p "Where should we install our deployment(blank for default)?: "
[ ! -z $REPLY ] && export CONTEXT_ROOT=$REPLY