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

echo "sensorservice" > /proc/conbinder/sharedservices
#echo "location" > /proc/conbinder/sharedservices
echo "batteryproperties" > /proc/conbinder/sharedservices
echo "android.security.keystore" > /proc/conbinder/sharedservices
echo "SurfaceFlinger" > /proc/conbinder/sharedservices
#echo "persistent_data_block" > /proc/conbinder/sharedservices
echo "nfc" > /proc/conbinder/sharedservices
#echo "android.os.UpdateEngineService" > /proc/conbinder/sharedservices
#echo "bluetooth_manager" > /proc/conbinder/sharedservices
#echo "android.service.gatekeeper.IGateKeeperService" > /proc/conbinder/sharedservices

#echo "power" > /proc/conbinder/sharedservices

#echo "telecom" > /proc/conbinder/sharedservices
#echo "iphonesubinfo" > /proc/conbinder/sharedservices
#echo "phone" > /proc/conbinder/sharedservices
#echo "carrier_config" > /proc/conbinder/sharedservices
#echo "telephony.registry" > /proc/conbinder/sharedservices

# audio part
#echo "audio" > /proc/conbinder/sharedservices
echo "media.audio_policy" > /proc/conbinder/sharedservices
echo "media.audio_flinger" > /proc/conbinder/sharedservices
echo "media.sound_trigger_hw" > /proc/conbinder/sharedservices
echo "media.radio" > /proc/conbinder/sharedservices

# camera part
#echo "media.camera" > /proc/conbinder/sharedservices
##echo "media.camera.proxy" > /proc/conbinder/sharedservices

cat /proc/conbinder/sharedservices
