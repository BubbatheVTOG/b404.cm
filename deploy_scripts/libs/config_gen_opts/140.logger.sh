#!/bin/sh
read -p "Deploy logger(blank for default(no))?: "
[[ $REPLY =~ ^[Yy]$ ]] && export LOGGER=True