#!/bin/sh

# IP address is not needed when we have a fqdn.
[ ! -z $FQDN ] && return 0

# Source: https://www.linuxjournal.com/content/validating-ip-address-bash-script
function valid_ip () {
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

read -p "What is the IPv4 address of the remote server(mandatory)?: "

[ -z $REPLY ] && echo "You must provide a remote IP address." && exit 1

valid_ip $REPLY
IS_GOOD=$?
while [[ "$IS_GOOD" -eq "0" ]]; do
    echo "You must provide a valid IP address."
    read -p "What is the IPv4 address of the remote server(mandatory)?: "
done
export REMOTE_IP=$REPLY