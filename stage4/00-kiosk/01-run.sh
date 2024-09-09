#!/bin/bash -xe

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s|example_kiosk_url|$KIOSK_URL|g" "$file"
        sed -i "s|example_user|$FIRST_USER_NAME|g" "$file"
    fi
done

install -v -m 644 files/xsession   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.xsession"
install -v -d                      "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/i3"
install -v -m 644 files/i3config   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/.config/i3/config"
install -v -m 600 files/autologin.conf   "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/"
install -v -m 600 files/lightdm.conf   "${ROOTFS_DIR}/etc/lightdm/"

