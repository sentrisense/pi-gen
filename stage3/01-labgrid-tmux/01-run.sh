#!/bin/bash -xe 

cd /home/$FIRST_USER_NAME

git clone https://github.com/labgrid-project/labgrid
cd labgrid
git checkout 1ab0abda791c00e448cbbb8c44a61564efbd16e9

virtualenv -p python3 labgrid-venv
source labgrid-venv/bin/activate
pip install --upgrade pip
pip install .

