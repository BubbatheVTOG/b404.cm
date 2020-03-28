#!/bin/sh

# Branch regex
# Dev/dev
# Testing/testing
# Master/master
function validate_branch () {
    REG="^(t|T)esting$|^(D|d)ev$|^(M|m)aster$"
    egrep -q $REG <<< $1
    return $?
}

read -p "Which branch of the software would you like to deploy (blank for master)?: "
[ -z $REPLY ] && return 0
if validate_branch $REPLY; then 
    export BRANCH=$REPLY
else
    echo "Invalid branch name!"
    exit 1
fi