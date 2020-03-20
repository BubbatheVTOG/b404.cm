#!/bin/sh

# Clear everything from the screen.
clear

print_center "This is a guide to help you generate a deployment configuration."

CONFIG_OPTS=$(ls -l $PROJECT_DIR/deploy_scripts/libs/config_gen_opts/*.sh)

for CONFIG_OPT in $CONFIG_OPTS; do
    source CONFIG_OPT
done