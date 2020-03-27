#!/bin/sh
read -p "Is this deployment going to be used for development(Y/y): "
[[ $REPLY =~ ^[Yy]$ ]] && export DEV_DEPLOY=True