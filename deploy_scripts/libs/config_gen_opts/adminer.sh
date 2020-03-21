#!/bin/sh
read -p "Deploy Adminer(blank for default)?: "
[[ $REPLY =~ ^[Yy]$ ]] && export ADMINER=True