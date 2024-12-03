#!/bin/bash -xe 

cd /home/$FIRST_USER_NAME

if [ -d "labgrid" ]; then
    rm -rf "labgrid"
fi

git clone https://github.com/xcancerberox/labgrid.git
cd labgrid
git checkout add_driver_strategy
cd ..
chown -R $FIRST_USER_NAME:$FIRST_USER_NAME labgrid
