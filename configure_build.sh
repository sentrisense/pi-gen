#!/bin/bash

# Get config from user
read -p "Insert host name number (two digits): " host_name_number

read -p "Insert user name: " user_name

read -s -p "Insert a password: " password
echo

read -p "Insert WPA country for the host (example: AR/ES/EU): " wpa_country

read -p "Insert netbird setup key: " netbird_setup_key

read -p "Insert Sentrisense token: " sentrisense_token

read -p "Insert Emnify token: " emnify_token

read -p "Insert github token: " github_token

read -p "Insert wifi SSID " wifi_ssid

read -s -p "Insert wifi password: " wifi_pswd
echo

read -s -p "Insert password for Django admin: " django_pswd
echo

# Create config file
echo "export IMG_NAME='Raspbian'" > config
echo "export RELEASE='bookworm'" >> config
echo "export ENABLE_SSH=1" >> config
echo "export TARGET_HOSTNAME='testingenv$host_name_number'" >> config
echo "export FIRST_USER_NAME='$user_name'" >> config
echo "export FIRST_USER_PASS='$password'" >> config
echo "export NETBIRD_SETUP_KEY='$netbird_setup_key'" >> config
echo "export GITHUB_TOKEN='$github_token'" >> config
echo "export WIFI_SSID='$wifi_ssid'" >> config
echo "export WIFI_PSWD='$wifi_pswd'" >> config
echo "DISABLE_FIRST_BOOT_USER_RENAME=1" >> config
echo "WPA_COUNTRY='$wpa_country'" >> config
echo "export SENTRISENSE_TOKEN='$sentrisense_token'" >> config
echo "export EMNIFY_TOKEN='$emnify_token'" >> config
echo "export DJANGO_PSWD='$django_pswd'" >> config
echo "config file created, run ./build-docker.sh"
