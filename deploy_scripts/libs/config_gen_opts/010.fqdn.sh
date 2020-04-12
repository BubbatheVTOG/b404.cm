#!/bin/sh
read -p "What is the FQDN of the server(blank for none)?: "
[ ! -z $REPLY ] && export FQDN=$REPLY

echo -e "Because you defined a FQDN we need an email for LetsEncrypt certificates account."
echo -e "You will recive emails about the status of the certificates being installed."
read -p "What email would you like to supply for certificate notifications: "
while [ -z $REPLY ]; do
    echo -e "Value is MANDATORY!"
    read -p "LetsEncrypt account email: " 
done
export LE_TOS_EMAIL=$REPLY