#!/system/bin/sh
MODDIR=${0%/*}

# DNS Changer
resetprop net.dns1
resetprop net.dns2
resetprop net.eth0.dns1
resetprop net.eth0.dns2
resetprop net.ppp0.dns1
resetprop net.ppp0.dns2
resetprop net.rmnet0.dns1
resetprop net.rmnet0.dns2
resetprop net.rmnet1.dns1
resetprop net.rmnet1.dns2
resetprop net.pdpbr1.dns1
resetprop net.pdpbr1.dns2
resetprop net.lte.dns1
resetprop net.lte.dns2
