#!/system/bin/sh -x

./mount-rootfs.sh

sleep 2

mkdir -p /data/maru/con1/con-data/misc/ethernet
cp -a -f ./ipconfig.txt /data/maru/con1/con-data/misc/ethernet/ipconfig.txt
chmod 755 /data/maru/con1/con-data/misc/ethernet/ipconfig.txt

#mkdir -p /data/maru/con1/rootfs/data/misc/ethernet

#./allcpuon.sh
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

./service-share-audio.sh
#./service-share-camera.sh
sleep 1

result=${PWD##*/}    #store current dir name to $result
parentdir=$(dirname $PWD)


##################################
####    misc          ####
##################################
##setenforce 0  ###lets remove selinux from kernel instead of any workaround in userspace

##################################
###    Backup Logs            ####
#################################
mv -f log log.old 2>/dev/null

##############################
##### BR0 ####################
##############################
FOUND=`grep br0 /proc/net/dev`                                   
if [ -n "$FOUND" ] ; then                  
  echo "br0 exists, skip"                                   
else                                                                          
  busybox brctl addbr br0 
  ifconfig br0 up                                                        
  ifconfig br0 192.168.9.1
fi 

busybox brctl show

#echo "1" > /proc/container/active

##################################
####   run lxc                ####
##################################
#LD_PRELOAD=/system/lib/liblxc.so  lxc-start -d  -P $parentdir -n $result /init --logfile=./log --logpriority=DEBUG
#LD_LIBRARY_PATH=/data/cba/local/lib /data/cba/local/bin/lxc-start -d  -P $parentdir -n $result /init --logfile=./log --logpriority=DEBUG
#LD_LIBRARY_PATH=/data/cba/local/lib /data/cba/local/bin/lxc-start -d -f ./config -P $parentdir -n $result --logfile=./log --logpriority=DEBUG -- /init --second-stage
#LD_LIBRARY_PATH=/odm/lib /odm/bin/lxc-start -d -f ./config -P $parentdir -n $result --logfile=./log --logpriority=DEBUG -- runcon u:r:init:s0 /init
#LD_LIBRARY_PATH=/odm/lib runcon u:r:init:s0 /odm/bin/lxc-start -d -f ./config -P $parentdir -n $result --logfile=./log --logpriority=DEBUG -- /init
#LD_LIBRARY_PATH=/data/cba/local/lib runcon u:r:init:s0 lxc-start -d -f ./config -P $parentdir -n $result --logfile=./log --logpriority=DEBUG -- /init
LD_LIBRARY_PATH=/odm/lib runcon u:r:init:s0 /odm/bin/lxc-start -d -f ./config -P $parentdir -n $result --logfile=./log --logpriority=DEBUG -- /init
#export LD_LIBRARY_PATH=/data/cba/local/lib:$LD_LIBRARY_PATH
#export PATH=/data/cba/local/bin:$PATH
#lxc-start -P $parentdir -n $result /init --logfile=./log --logpriority=DEBUG

##################################
#   ebable NAT ip rule       
##################################
./nat.sh

#stop media 
#start media

