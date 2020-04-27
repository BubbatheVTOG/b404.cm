#!/bin/bash
certbot certonly -n --agree-tos --email $1 --standalone --preferred-challenges http -d $2