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

mount -o rw,remount /

chmod -R 0755 /odm/bin
chmod -R 0755 /odm/xbin
chmod -R 0755 /odm/libexec
chmod -R 755 /odm/libexec/lxc

# GMS specific
chmod 755 /system/addon.d/70-gapps.sh
chcon -h u:object_r:system_file:s0 /system/addon.d/70-gapps.sh
chmod 644 /system/etc/g_prop
chcon -h u:object_r:system_file:s0 /system/etc/g.prop

/system/xbin/busybox --install -s /system/xbin

mount -o ro,remount /
