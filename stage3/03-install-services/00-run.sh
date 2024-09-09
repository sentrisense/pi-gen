#!/bin/bash -xe

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s/example_user/$FIRST_USER_NAME/g" "$file"
        sed -i "s/example_key/$NETBIRD_SETUP_KEY/g" "$file"
        sed -i "s/example_wifi_ssid/$WIFI_SSID/g" "$file"
        sed -i "s/example_wifi_pswd/$WIFI_PSWD/g" "$file"
    fi
done

install -v -d                               "${ROOTFS_DIR}/etc/labgrid"
install -v -m 644 files/exporter.yaml       "${ROOTFS_DIR}/etc/labgrid/"
install -v -m 644 files/exporter_factory.yaml       "${ROOTFS_DIR}/etc/labgrid/"
install -v -m 644 files/coordinator.yaml    "${ROOTFS_DIR}/etc/labgrid/"
install -v -m 777 files/tmux-labgrid.sh     "${ROOTFS_DIR}/home/$FIRST_USER_NAME/"

install -v -m 600 -D files/sysusers.d/*	"${ROOTFS_DIR}/etc/"
install -v -m 600 -D files/tmpfiles.d/*	"${ROOTFS_DIR}/etc/"

install -v -m 600 files/labgrid-coordinator.service	"${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/labgrid-exporter.service	"${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/netbird-up.service	        "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/inet-up.service	            "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/tmux.service            	"${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    systemctl enable inet-up.service
    systemctl enable labgrid-coordinator.service
    systemctl enable labgrid-exporter.service
    systemctl enable tmux.service
    systemctl enable netbird-up.service
EOF

# create ssh keys & add to authorized
yes "" |  ssh-keygen -N ""
# add pubkey to authorized_keys (needed by labgrid)
cat ${ROOTFS_DIR}/home/$FIRST_USER_NAME/.ssh/id_rsa.pub >> ${ROOTFS_DIR}/home/$FIRST_USER_NAME/.ssh/authorized_keys

