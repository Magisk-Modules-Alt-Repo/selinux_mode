#!/system/bin/sh
MODDIR=${0%/*}

# DNS Changer
iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination :53
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination :53

# Internet Tweak
echo "0" > /proc/sys/net/ipv4/tcp_timestamps
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling
echo "1048576" > /proc/sys/net/core/rmem_max
echo "1048576" > /proc/sys/net/core/wmem_max
echo "262144" > /proc/sys/net/core/rmem_default
echo "262144" > /proc/sys/net/core/wmem_default
echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout
echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes
echo "6144,16384,1048576" > /proc/sys/net/ipv4/tcp_wmem
echo "6144,87380,1048576" > /proc/sys/net/ipv4/tcp_rmem

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
