#!/bin/sh
read -p "Deploy Adminer(blank for default)?: " -n 1 -r
test $REPLY =~ ^[Yy]$ && export ADMINER=True