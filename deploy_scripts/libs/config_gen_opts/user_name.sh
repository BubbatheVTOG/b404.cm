#!/bin/bash
read -p "What is the remote user name you would like to create (blank for default): " -n 1 -r
echo
export USER_NAME=$REPLY
