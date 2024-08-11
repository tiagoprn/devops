#!/usr/bin/env bash

# Check if at least one port is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 port1 [port2 ... portN]"
    exit 1
fi

# Iterate over each port passed as an argument
for port in "$@"; do
    echo "Listing iptables rules for port $port:"
    sudo iptables -t nat -L -v -n --line-numbers | grep "$port"
    echo ""
done
