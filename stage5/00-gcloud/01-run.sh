#!/bin/bash -xe

install -v -m 777 files/backend-key.json   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/"

curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz

tar -xf google-cloud-cli-linux-x86_64.tar.gz

yes "" | ./google-cloud-sdk/install.sh

gcloud auth activate-service-account  devel-and-manufacturing-rpi@less-backend.iam.gserviceaccount.com  --key-file=/home/$FIRST_USER_NAME/backend-key.json


