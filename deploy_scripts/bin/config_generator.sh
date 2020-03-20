#!/bin/sh

# Clear everything from the screen.
clear

print_center "This is a guide to help you generate a deployment configuration."

CONFIG_OPTS_DIR=$PROJ_ROOT/deploy_scripts/libs/config_gen_opts
for CONFIG_OPT in $(ls $CONFIG_OPTS_DIR/*.sh); do
    source /$CONFIG_OPT
done