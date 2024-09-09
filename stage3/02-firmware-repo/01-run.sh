#!/bin/bash -xe 

cd ${ROOTFS_DIR}/home/$FIRST_USER_NAME

if [ -d "firmware" ]; then
    rm -rf "firmware"
fi

git config --global user.name "$FIRST_USER_NAME"
git config --global user.email "$FIRST_USER_NAME@sentrisense.com"


git clone https://"$GITHUB_TOKEN"@github.com/sentrisense/firmware.git

#cd firmware
#git remote add nacho git@github.com:nachocarballeda/firmware.git
#git remote add joaco git@github.com:xcancerberox/firmware.git
#git remote add pato git@github.com:pamoreno/firmware.git

#git remote update
#git checkout pato/add_4_0_support
#cd testing/factory

#on_chroot << EOF
#    virtualenv -p python3 venv
#    source venv/bin/activate
#    pip install --upgrade pip
#    pip install -r requirements.txt
#    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME venv
#EOF
