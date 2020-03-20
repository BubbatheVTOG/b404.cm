#!/bin/sh
read -p "Deploy Adminer(blank for default)?: " -n 1
test $REPLY =~ ^[Yy]$ && export ADMINER=True