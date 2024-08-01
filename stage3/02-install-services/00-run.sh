#!/bin/bash -e

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s/example_user/$FIRST_USER_NAME/g" "$file"
        sed -i "s/example_key/$NETBIRD_SETUP_KEY/g" "$file"
    fi
done

install -v -d                               "${ROOTFS_DIR}/etc/labgrid"
install -v -m 777 files/exporter.yaml       "${ROOTFS_DIR}/etc/labgrid/"
install -v -m 777 files/coordinator.yaml    "${ROOTFS_DIR}/etc/labgrid/"
install -v -m 777 files/tmux-labgrid.sh     "${ROOTFS_DIR}/home/$FIRST_USER_NAME/"
install -v -m 777 files/netbird-up.sh       "${ROOTFS_DIR}/home/$FIRST_USER_NAME/"

install -v -m 600 -D files/sysusers.d/*	"${ROOTFS_DIR}/etc/"
install -v -m 600 -D files/tmpfiles.d/*	"${ROOTFS_DIR}/etc/"

install -v -m 600 files/labgrid-coordinator.service	"${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/labgrid-exporter.service	"${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/netbird-up.service	        "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 600 files/tmux.service            	"${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF
    systemctl enable labgrid-coordinator.service
EOF

on_chroot << EOF
    systemctl enable labgrid-exporter.service
EOF

on_chroot << EOF
    systemctl enable tmux.service
EOF

on_chroot << EOF
    systemctl enable netbird-up.service
EOF
