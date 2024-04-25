#!/bin/sh

echo "init.."

# docker logs
tail -f /var/log/idrive.log

# Install idriveforlinux.bin
cd /work
./idriveforlinux.bin --install

# Idrive installation folder
cd /opt/IDriveForLinux/bin