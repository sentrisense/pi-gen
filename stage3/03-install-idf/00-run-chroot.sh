#!/bin/bash -e

cd /home/$FIRST_USER_NAME

if [ -d "esp-idf" ]; then
    rm -rf "esp-idf"
fi

git config --global http.postBuffer 157286400

git clone -b v5.2.1 --recursive https://github.com/espressif/esp-idf.git

cd esp-idf

./install.sh esp32 esp32s2 --enable-pytest

