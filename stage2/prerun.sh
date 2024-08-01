#!/bin/bash -e

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi

cat << EOF >> "02-net-tweaks/files/wpa_supplicant.conf"
country=${WPA_COUNTRY}

network={
    ssid="${WIFI_SSID}"
    psk="${WIFI_PSWD}"
}
