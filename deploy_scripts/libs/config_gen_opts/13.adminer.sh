#!/bin/sh
read -p "Deploy Adminer(blank for default(no))?: "
[[ $REPLY =~ ^[Yy]$ ]] && export ADMINER=True