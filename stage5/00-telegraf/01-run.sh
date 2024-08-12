#!/bin/bash -xe

for file in files/*; do
    if [ -f "$file" ]; then
        sed -i "s|example_target|$TARGET_HOSTNAME|g" "$file"
        sed -i "s|example_user|$FIRST_USER_NAME|g" "$file"
    fi
done

on_chroot << EOF

wget -q https://repos.influxdata.com/influxdata-archive_compat.key

echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null

echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | tee /etc/apt/sources.list.d/influxdata.list

apt-get update                 
apt-get install telegraf

rm ${ROOTFS_DIR}/etc/telegraf/telegraf.conf

EOF

install -v -m 600 files/telegraf.conf   "${ROOTFS_DIR}/etc/telegraf/telegraf.conf"
install -v -m 600 files/override.conf   "${ROOTFS_DIR}/etc/systemd/system/telegraf.service.d/"

