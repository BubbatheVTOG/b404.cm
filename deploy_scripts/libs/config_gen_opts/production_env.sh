#!/bin/sh
read -p "Is this a production deployment(Y/y): "
test $REPLY =~ ^[Yy]$ && export PROD=True