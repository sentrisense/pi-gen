#!/bin/bash -e

apt-get update
apt-get install ca-certificates curl gnupg -y
rm -f /usr/share/keyrings/netbird-archive-keyring.gpg
curl -sSL https://pkgs.netbird.io/debian/public.key | gpg --batch --dearmor --output /usr/share/keyrings/netbird-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/netbird-archive-keyring.gpg] https://pkgs.netbird.io/debian stable main' | tee /etc/apt/sources.list.d/netbird.list
apt-get update
