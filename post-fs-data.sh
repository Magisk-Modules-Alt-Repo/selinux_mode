#!/system/bin/sh
MODDIR=${0%/*}
# Selinux Changer
setenforce

# Delete Some Files
rm -rf $MODPATH/update.json
rm -rf $MODPATH/changelog.md
rm -rf $MODPATH/README.md
rm -rf $MODPATH/LICENSE
rm -rf $MODPATH/service.sh

# Cache Cleaner
rm -rf /storage/emulated/0/Android/data/*/cache/*
rm -rf /data/data/*/cache/*
rm -rf /data/dalvik-cache/arm/*
rm -rf /data/dalvik-cache/arm64/*
rm -rf /cache/magisk.log
rm -rf /cache/magisk.log.bak
touch /cache/magisk.log
touch /cache/magisk.log.bak
chmod 644 /cache/magisk.log
chmod 644 /cache/magisk.log.bak