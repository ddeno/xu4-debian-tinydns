#!/bin/bash

# Lets create our database "/etc/ndjbdns/data.cdb"
cd /etc/ndjbdns;
tinydns-data;

# Run tinydns as a daemon
tinydns -D
dnscache -D

# Create infinite loop to keep container running
while true; do
    sleep 1;
done;

