#!/system/bin/sh -x
#
# Copyright (C) 2015-2017 The Android Container Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# we need push container image files onto this director
# so we need write permission on this directory
if [ ! -d "/data/maru" ]; then
    mkdir /data/maru
    chmod 777 /data/maru
fi

if [ ! -d "/data/maru/con1" ]; then
    mkdir /data/maru/con1
    chmod 777 /data/maru/con1
fi

if [ ! -f "/data/maru/con1/mount-rootfs.sh" ]; then
    cp /odm/maru/con1/mount-rootfs.sh /data/maru/con1/mount-rootfs.sh
    chmod 0755 /data/maru/con1/mount-rootfs.sh
fi

if [ ! -f "/data/maru/con1/nat.sh" ]; then
    cp /odm/maru/con1/nat.sh /data/maru/con1/nat.sh
    chmod 0755 /data/maru/con1/nat.sh
fi

if [ ! -f "/data/maru/con1/run.sh" ]; then
    cp /odm/maru/con1/run.sh /data/maru/con1/run.sh
    chmod 0755 /data/maru/con1/run.sh
fi

if [ ! -f "/data/maru/con1/config" ]; then
    cp /odm/maru/con1/config /data/maru/con1/config
    chmod 0666 /data/maru/con1/config
fi

if [ ! -f "/data/maru/con1/ipconfig.txt" ]; then
    cp /odm/maru/con1/ipconfig.txt /data/maru/con1/ipconfig.txt
    chmod 0666 /data/maru/con1/ipconfig.txt
fi

if [ ! -f "/data/maru/con1/con-rootfs" ]; then
    mkdir -p /data/maru/con1/con-rootfs
    mkdir -p /data/maru/con1/con-data
    mkdir -p /data/maru/con1/con-persist
    mkdir -p /data/maru/con1/con-vendor
    mkdir -p /data/maru/con1/lxc-rootfs.mount
fi

