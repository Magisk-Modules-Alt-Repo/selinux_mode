SKIPUNZIP=1

PRINT() {
    ui_print "Selinux Changer Mode By Yudha"
    ui_print "• Worked For Audio Mod Like Dolby Atmos Or ViperFX,"
    ui_print "• With 2 Mode Selinux Changer"
    ui_print "• Change Your Selinux Mode."
    ui_print ""
    sleep 1.5
}

EXEC() {
    ui_print "Installing..."
    sleep 1.5
    ui_print "- Extracting module files"
    unzip -o "$ZIPFILE" 'addon/*' -d $MODPATH >&2
    unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
    unzip -o "$ZIPFILE" module.prop -d $MODPATH >&2
    unzip -o "$ZIPFILE" post-fs-data.sh -d $MODPATH >&2
    unzip -o "$ZIPFILE" service.sh -d $MODPATH >&2
    unzip -o "$ZIPFILE" uninstall.sh -d $MODPATH >&2
    ui_print ""
    sleep 1.5
    
    . $MODPATH/addon/Volume-Key-Selector/install.sh
    
    ui_print "Select Selinux Mode."
    ui_print " 1. Selinux Enforcing"
    ui_print " 2. Selinux Permissive"
    ui_print ""
    sleep 0.5
    
    A=1
    while true; do
        ui_print "$A"
        if $VKSEL; then
            A=$((A + 1))
        else
            break
        fi
        if [ $A -gt 2 ]; then
            A=1
        fi
    done
    ui_print "Selected: $A"
    case $A in
        1 ) TEXT1="Selinux Enforcing"; sed -i '/setenforce/s/.*/setenforce 1/' $MODPATH/post-fs-data.sh;;
        2 ) TEXT1="Selinux Permissive"; sed -i '/setenforce/s/.*/setenforce 0/' $MODPATH/post-fs-data.sh;;
        esac
    ui_print "- $TEXT1"
    ui_print ""
    sleep 1
    
    rm -rf $MODPATH/addon
    rm -rf $MODPATH/service.sh
}

if [ ! "$SKIPUNZIP" = "0" ]; then
    set -x
    PRINT
    EXEC
else
    set +x
    abort
fi
