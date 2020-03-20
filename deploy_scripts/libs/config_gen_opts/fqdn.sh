#!/bin/sh
read -p "What is the FQDN of the server (blank for none): " -n 1 -r
echo #remove whitespace from buffer
export FQDN=$REPY
