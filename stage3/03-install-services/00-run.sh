#!/bin/bash -xe

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s/example_user/$FIRST_USER_NAME/g" "$file"
        sed -i "s/example_key/$NETBIRD_SETUP_KEY/g" "$file"
        sed -i "s/example_wifi_ssid/$WIFI_SSID/g" "$file"
        sed -i "s/example_wifi_pswd/$WIFI_PSWD/g" "$file"
        sed -i "s/EMNIFY_TOKEN_EXAMPLE/$EMNIFY_TOKEN/g" "$file"
        sed -i "s/SENTRI_TOKEN_EXAMPLE/$SENTRISENSE_TOKEN/g" "$file"
        sed -i "s/DJANGO_SUPERUSER_PASSWORD_EXAMPLE/$DJANGO_PSWD/g" "$file"
    fi
done

install -v -m 755 -d "${ROOTFS_DIR}/home/$FIRST_USER_NAME/scripts"
install -v -m 777 files/tmux-up.sh     "${ROOTFS_DIR}/home/$FIRST_USER_NAME/scripts/"
install -v -m 777 files/get_keys.sh    "${ROOTFS_DIR}/home/$FIRST_USER_NAME/scripts/"
install -v -m 777 files/run_server.sh  "${ROOTFS_DIR}/home/$FIRST_USER_NAME/scripts/"

install -v -m 600 -D files/sysusers.d/*	"${ROOTFS_DIR}/etc/"
install -v -m 600 -D files/tmpfiles.d/*	"${ROOTFS_DIR}/etc/"

install -v -m 600 files/netbird-up.service	        "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/authorized-keys.service	    "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/inet-up.service	            "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/tmux-up.service            	"${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/factory.service            	"${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    systemctl enable inet-up.service
    systemctl enable tmux-up.service
    systemctl enable netbird-up.service
    systemctl enable authorized-keys.service
    systemctl enable factory.service
EOF

