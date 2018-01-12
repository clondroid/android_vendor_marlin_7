#!/system/bin/sh  

 ip rule add from all lookup main

 iptables -F 
 iptables -t nat -F 

 iptables -P INPUT ACCEPT 
 iptables -P OUTPUT ACCEPT 
 iptables -P FORWARD DROP 

##Copy and paste these exports 
 export LAN=br0
 export WAN=wlan0

###Finally we add the rules for NAT 
 iptables -I FORWARD -i ${LAN} -d 192.168.0.0/255.255.0.0 -j DROP 
 iptables -A FORWARD -i ${LAN} -s 192.168.0.0/255.255.0.0 -j ACCEPT 
 iptables -A FORWARD -i ${WAN} -d 192.168.0.0/255.255.0.0 -j ACCEPT 
 iptables -t nat -A POSTROUTING -o ${WAN} -j MASQUERADE 
 iptables -t nat -A POSTROUTING -o ${LAN} -j MASQUERADE 

###Tell the kernel that ip forwarding is OK 
 echo 1 > /proc/sys/net/ipv4/ip_forward 
 for f in /proc/sys/net/ipv4/conf/*/rp_filter ; do echo 1 > $f ; done 

#This is so when we boot we don't have to run the rules by hand 
# /etc/init.d/iptables save 
# rc-update add iptables default 
# nano /etc/sysctl.conf 
#Add/Uncomment the following lines: 
#net.ipv4.ip_forward = 1 
#net.ipv4.conf.default.rp_filter = 1 
#
#If you have a dynamic internet address you probably want to enable this: 
#net.ipv4.ip_dynaddr = 1 
