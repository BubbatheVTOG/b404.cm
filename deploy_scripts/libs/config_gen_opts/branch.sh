#!/bin/sh

# Branch regex
# Dev/dev/Development/development
# Testing/testing
# Master/master
function set_branch () {
    REG='^(t|T)esting$|^(D|d)ev$|^(D|d)evelopment$|^(M|m)aster$'
    return grep -E $REG $1
}

read -p "Which branch would you like to deploy (blank for defalt)?: "
[ -z $REPLY ] && return 0
set_branch $REPLY && export BRANCH=$REPLY || echo "Invalid branch name!"; exit 1