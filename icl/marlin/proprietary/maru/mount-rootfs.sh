losetup /dev/block/loop0 /data/maru/con1/system.img.raw
mount /dev/block/loop0 con-rootfs
sleep 1

losetup /dev/block/loop1 /data/maru/con1/data.img.raw
mount /dev/block/loop1 con-data
sleep 1

losetup /dev/block/loop2 /data/maru/con1/data-persist.img.raw 
mount /dev/block/loop2 con-persist
sleep 1

#losetup /dev/block/loop3 /data/maru/con1/vendor.img.raw
#mount /dev/block/loop3 con-vendor
#sleep 1
