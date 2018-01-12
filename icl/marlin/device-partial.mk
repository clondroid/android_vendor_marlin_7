# Copyright 2016 The Android Open Source Project
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

#  blob(s) necessary for ICL LXC Container
PRODUCT_COPY_FILES := \
    vendor/icl/marlin/proprietary/xbin/busybox_static:system/xbin/busybox:icl

ifeq ($(TARGET_PRODUCT),aosp_marlin_con)
    PRODUCT_COPY_FILES += \
        vendor/icl/marlin/proprietary/xbin/init-odm-icl_con.sh:system/xbin/init-odm-icl.sh:icl
else
    PRODUCT_COPY_FILES += \
        $(call find-copy-subdir-files-vendor,*,vendor/icl/marlin/proprietary/bin,root/odm/bin,icl) \
        vendor/icl/marlin/proprietary/lib/liblxc.la:root/odm/lib/liblxc.la:icl \
        vendor/icl/marlin/proprietary/lib/liblxc.so:root/odm/lib/liblxc.so:icl \
        $(call find-copy-subdir-files-vendor,*,vendor/icl/marlin/proprietary/libexec/lxc,root/odm/libexec/lxc,icl) \
        vendor/icl/marlin/proprietary/xbin/init-odm-icl.sh:system/xbin/init-odm-icl.sh:icl \
        vendor/icl/marlin/proprietary/xbin/config-shared-services.sh:root/odm/xbin/config-shared-services.sh:icl \
        vendor/icl/marlin/proprietary/xbin/init-data-icl.sh:root/odm/xbin/init-data-icl.sh:icl \
	vendor/icl/marlin/proprietary/xbin/start-container.sh:root/odm/xbin/start-container.sh:icl \
        vendor/icl/marlin/proprietary/xbin/start-lxcd.sh:root/odm/xbin/start-lxcd.sh:icl \
	vendor/icl/marlin/proprietary/xbin/switch-con.sh:root/odm/xbin/switch-con.sh:icl \
	\
	vendor/icl/marlin/proprietary/maru/mount-rootfs.sh:root/odm/maru/con1/mount-rootfs.sh:icl \
	vendor/icl/marlin/proprietary/maru/run.sh:root/odm/maru/con1/run.sh:icl \
	vendor/icl/marlin/proprietary/maru/nat.sh:root/odm/maru/con1/nat.sh:icl \
        vendor/icl/marlin/proprietary/maru/config:root/odm/maru/con1/config:icl \
	vendor/icl/marlin/proprietary/maru/ipconfig.txt:root/odm/maru/con1/ipconfig.txt:icl
endif

PRODUCT_PACKAGES += \
    ASwitch

#  blob(s) necessary for install GMS
GMS_COPY_FILES := \
    $(call find-copy-subdir-files-vendor,*,vendor/icl/marlin/proprietary/open_gapps-arm64-7.1-mini/common,system,icl) \
    $(call find-copy-subdir-files-vendor,*,vendor/icl/marlin/proprietary/open_gapps-arm64-7.1-mini/app,system/app,icl) \
    $(call find-copy-subdir-files-vendor,*,vendor/icl/marlin/proprietary/open_gapps-arm64-7.1-mini/priv-app,system/priv-app,icl) \
    vendor/icl/marlin/proprietary/open_gapps-arm64-7.1-mini/g.prop:system/etc/g.prop:icl \
    vendor/icl/marlin/proprietary/open_gapps-arm64-7.1-mini/70-gapps.sh:system/addon.d/70-gapps.sh:icl

GAPPS_AOSP_EXCLUDED_PACKAGES := \
    ExtServices \
    Calendar \
    DeskClock \
    ExactCalculator \
    Provision

