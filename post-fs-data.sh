#!/system/bin/sh
MODDIR=${0%/*}

# DNS Changer
resetprop -n net.dns1
resetprop -n net.dns2
resetprop -n net.eth0.dns1
resetprop -n net.eth0.dns2
resetprop -n net.ppp0.dns1
resetprop -n net.ppp0.dns2
resetprop -n net.rmnet0.dns1
resetprop -n net.rmnet0.dns2
resetprop -n net.rmnet1.dns1
resetprop -n net.rmnet1.dns2
resetprop -n net.pdpbr1.dns1
resetprop -n net.pdpbr1.dns2
resetprop -n net.lte.dns1
resetprop -n net.lte.dns2
