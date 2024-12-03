#!/bin/bash -xe 

cd ${ROOTFS_DIR}/home/$FIRST_USER_NAME

if [ -d "firmware" ]; then
    rm -rf "firmware"
fi

git config --global user.name "$FIRST_USER_NAME"
git config --global user.email "$FIRST_USER_NAME@sentrisense.com"

on_chroot << EOF
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    cd /home/$FIRST_USER_NAME
    git clone https://"$GITHUB_TOKEN"@github.com/nachocarballeda/firmware.git
    git config --global --add safe.directory /home/$FIRST_USER_NAME/firmware
    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME /home/$FIRST_USER_NAME/firmware
    cd firmware
    git fetch origin
    git checkout factory_testing_fix
    cd testing/factory
    virtualenv -p python3 venv
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME venv
    cd factory_manager
    python manage.py migrate
    deactivate
    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME /home/$FIRST_USER_NAME/firmware
EOF

