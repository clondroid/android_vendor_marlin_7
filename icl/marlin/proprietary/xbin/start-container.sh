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

TAG=myboot

# Before we can start the container, we need toc check if host has been provisioned
# We need to prevent host and container running setupwizard @ the same time  
while true; do
    if [[ $(/system/bin/settings get global device_provisioned) == "0" ]]; then
        log -t $TAG *****waiting for host to finish provision***
	sleep 12
    else
        break
    fi
done

while [ `ps|grep launcher|wc -l` -eq 0 ] 
do
 log -t $TAG *****waiting for launcher***
 sleep 1
done

log -t $TAG ******start container****
cd /data/maru/con1
./run.sh

sleep 60

