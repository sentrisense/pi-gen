#!/bin/bash -xe 

cd /home/$FIRST_USER_NAME

git clone git@github.com:sentrisense/firmware.git
cd firmware

git remote add nacho git@github.com:nachocarballeda/pi-gen.git
git remote add joaco git@github.com:xcancerberox/firmware.git
git remote add pato git@github.com:pamoreno/firmware.git

git remote update

git checkout pato add_4_0_support

cd testing/factory
virtualenv -p python3 venv
source lvenv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

