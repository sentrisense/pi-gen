#!/bin/bash -xe

install -v -m 777 files/backend-key.json   "${ROOTFS_DIR}/home/$FIRST_USER_NAME/"

# Install google cloud cli (optional)
#curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
#tar -xf google-cloud-cli-linux-x86_64.tar.gz
#./google-cloud-sdk/install.sh --quiet --no-compile-python
#gcloud auth activate-service-account  devel-and-manufacturing-rpi@less-backend.iam.gserviceaccount.com  --key-file=/home/$FIRST_USER_NAME/backend-key.json

echo 'export GOOGLE_APPLICATION_CREDENTIALS=/home/${FIRST_USER_NAME}/backend-key.json' >> ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc

