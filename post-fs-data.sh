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