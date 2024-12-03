#!/bin/bash -xe

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s|example_user|$FIRST_USER_NAME|g" "$file"
    fi
done

# Disable user folder creation (Documents, Images, etc) , this is not working.. TODO: solve
mkdir ${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config
touch ${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/user-dirs.conf
echo 'enabled=False' > "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/user-dirs.conf"

install -v -m 644 files/xsession   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.xsession"
install -v -m 777 files/i3config.sh   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/scripts/i3config.sh"
install -v -m 644 files/autologin.conf   "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/"
install -v -m 644 files/lightdm.conf     "${ROOTFS_DIR}/etc/lightdm/"

install -v -m 600 files/setup-i3-config.service	"${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    chown -R $FIRST_USER_NAME:$FIRST_USER_NAME ${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config
    systemctl enable setup-i3-config.service
    cd ${ROOTFS_DIR}/home
    rm -r Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Videos/ Templates/
EOF

