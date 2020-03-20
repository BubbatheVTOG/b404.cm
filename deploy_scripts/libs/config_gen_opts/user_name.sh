#!/bin/bash
read -p "What is the remote username you would like to create(blank for default): "
[ -z $REPLY ] && export USER_NAME=$REPLY