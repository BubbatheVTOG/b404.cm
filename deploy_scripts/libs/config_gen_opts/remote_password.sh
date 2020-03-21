#!/bin/bash
set -x
read -p "Remote user password(blank for default)?: " 
[ -z $REPLY ] && exit 0

MKPASS_LOC=$(which mkpasswd)

export HASHED_PASSED=$($MKPASS_LOC --method=sha-512 $REPLY)
