#!/bin/bash -e 

cd /home/$FIRST_USER_NAME

if [ -d "labgrid" ]; then
    rm -rf "labgrid"
fi

git clone https://github.com/labgrid-project/labgrid

cd labgrid

virtualenv -p python3 crossbar-venv
crossbar-venv/bin/pip install --upgrade pip
crossbar-venv/bin/pip install -r crossbar-requirements.txt

virtualenv -p python3 labgrid-venv
source labgrid-venv/bin/activate

pip install --upgrade pip
pip install .


