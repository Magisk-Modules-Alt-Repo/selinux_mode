#!/system/bin/sh
MODDIR=${0%/*}

# DNS Changer
iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination :53
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination :53

# Virtual Memory Tweak
stop perfd
echo '0' > /proc/sys/vm/oom_kill_allocating_task
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo '100' > /proc/sys/vm/swappiness
echo '100' > /proc/sys/vm/vfs_cache_pressure
echo '128' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '128' > /sys/block/mmcblk1/queue/read_ahead_kb
echo '20' > /proc/sys/vm/dirty_background_ratio
echo '5' > /proc/sys/vm/dirty_ratio
echo '8000' > /proc/sys/vm/min_free_kbytes
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree
rm /data/system/perfd/default_values
start perfd
sleep 15

# Activity Manager Tweak
settings put global activity_manager_constants max_cached_processes=160
