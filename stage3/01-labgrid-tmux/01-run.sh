#!/bin/bash -xe 

cd ${ROOTFS_DIR}/home/$FIRST_USER_NAME

if [ -d "labgrid" ]; then
    rm -rf "labgrid"
fi

git clone https://github.com/labgrid-project/labgrid
cd labgrid
git checkout 1ab0abda791c00e448cbbb8c44a61564efbd16e9

on_chroot << EOF
    python3 -m venv labgrid-venv
    source labgrid-venv/bin/activate
    pip install --upgrade pip
    pip install /home/$FIRST_USER_NAME/labgrid
    deactivate
    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME labgrid-venv
EOF

