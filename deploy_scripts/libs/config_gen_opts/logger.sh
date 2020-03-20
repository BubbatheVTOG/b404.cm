#!/bin/sh
read -p "Deploy logger(blank for default)?: "
test $REPLY =~ ^[Yy]$ && export LOGGER=True