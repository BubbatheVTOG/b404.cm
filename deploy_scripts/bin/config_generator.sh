#!/bin/sh

if [ ! -f deployment.ini ]; then
    print_center "No previous deployment found. Let's make one together."
fi
print_center "This is a guide to help us generate a deployment configuration."
print_center "We can always re-run this guide again in the future to"
print_center "generate a different deployment configuration."
print_center " "

CONFIG_OPTS_DIR=$PROJ_ROOT/deploy_scripts/libs/config_gen_opts
for CONFIG_OPT in $(ls $CONFIG_OPTS_DIR/*.sh); do
    source $CONFIG_OPT
done