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

TAG=mylxcd
INTERVAL=1
FILE=/proc/container/active
RUN=/data/maru/RUN
INIT=/data/maru/INIT

log -t $TAG init

if [ -f $FILE ]
then
  log -t $TAG found $FILE
else
  log -t $TAG $FILE not found
fi


rm -f $INIT
rm -f $RUN

while true 
do
 ####debug###log -t $TAG loop


 if [ `ps|grep launcher|wc -l` -ge 2 ] && [ ! -f $RUN ]
 then
  log -t $TAG ******Container exist but no run file****
  log -t $TAG ******Make $RUN****
  touch $RUN
 fi

 if [ `ps|grep launcher|wc -l` -lt 2 ] && [ -f $RUN ]
 then
  log -t $TAG ******Container died but found $RUN
  log -t $TAG ******Remove $RUN****
  rm -f $RUN
 fi

 if [ `ps|grep /init|wc -l` -ge 2 ] && [ ! -f $INIT ]
 then
  log -t $TAG ******Container booting****
  log -t $TAG ******Make $INIT****
  touch $INIT
 fi

 if [ `ps|grep /init|wc -l` -lt 2 ] && [ -f $INIT ]
 then
  log -t $TAG ******Revmoe $INIT****
  rm -f $INIT
 fi

 sleep $INTERVAL

done


