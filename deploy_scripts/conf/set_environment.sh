#!/bin/bash

# The current absolute directory of the script.
export MY_DIR="$( cd -P "$(dirname "$0")" && pwd)"
export PROJ_ROOT=${MY_DIR}

# Setting this to true will format output.
export FORMAT=true

# Find our term width. Used for centerting text.
export TERMINAL_WIDTH=$(tput cols)

# Modules Directory
export mods_dir=${MY_DIR}/modules/

#Deployment inventory file
export DEPLOYMENT_FILE=$PROJ_ROOT/deployment.ini

# Library directory
export LIBS=$PROJ_ROOT/libs

# Exec directory
export BIN=$PROJ_ROOT/bin

# Config generator libs
export CONFIG_OPTS_DIR=$LIBS/config_gen_opts