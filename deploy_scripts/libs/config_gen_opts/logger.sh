#!/bin/sh
read -p "Deploy logger(blank for default)?: "
[[ $REPLY =~ ^[Yy]$ ]] && export LOGGER=True