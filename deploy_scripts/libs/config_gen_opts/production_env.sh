#!/bin/sh
read -p "Is this a production deployment(Y/y): "
[[ $REPLY =~ ^[Yy]$ ]] && export PROD=True