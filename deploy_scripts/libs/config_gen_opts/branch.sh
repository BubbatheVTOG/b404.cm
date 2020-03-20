#!/bin/sh
read -p "Which branch would you like to deploy (blank for defalt)?: "
test_branch $REPLY && export BRANCH=$REPLY || echo "Invalid branch name!"; exit 1

# Branch regex
# Dev/dev/Development/development
# Testing/testing
# Master/master
function test_branch() {
    REG='^(t|T)esting$|^(D|d)ev$|^(D|d)evelopment$|^(M|m)aster$'
    return grep -E $REG $1
}