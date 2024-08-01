#!/bin/bash

cd ~

# Generate SSH key pair
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

# Get the public key
public_key=$(cat ~/.ssh/id_rsa.pub)

# Copy the public key to remote host's known_hosts file
mkdir -p ~/.ssh && echo \"$public_key\" >> ~/.ssh/authorized_keys
