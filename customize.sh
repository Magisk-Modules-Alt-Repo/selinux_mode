SKIPUNZIP=1

PRINT() {
    ui_print "ML+ (Magisk Module for MLBB)"
    ui_print "• Unlock Ultra Graphics, 120FPS, Change GPU Rendering,"
    ui_print "• Change OpenGL ES Version, Improve Internet Connection, Touch Improvement, etc"
    ui_print "• For Mobile Legends: Bang Bang."
    ui_print ""
    sleep 2
    ui_print "All In One Module:"
    ui_print "• Device Info Changer (Xiaomi Mi 11 Ultra)."
    ui_print "• GPU Rendering Changer."
    ui_print "• OpenGL ES Version Changer."
    ui_print "• DNS Changer."
    ui_print "• Internet Tweak."
    ui_print "• Touch Improvement."
    ui_print "• RAM and VM Improvement."
    ui_print ""
    sleep 2
    ui_print "Notes:"
    ui_print "• This module will not work if you're using MagiskHide Props, DNS Changer, GPU Rendering Changer,"
    ui_print "• OpenGL ES Version Changer, Touch Improvement, Internet Tweak, Virtual Memory Tweak,"
    ui_print "• And RAM Management Tweak (Memory Improvement, Activity Manager Tweak, etc)"
    ui_print "• Or others similar modules with it."
    ui_print ""
    sleep 2
    ui_print "• And also, this module works in all games not only MLBB,"
    ui_print "• Called for MLBB only because of the unlocker method"
    ui_print "• And my personal use that made this module to play MLBB, thanks..."
    ui_print ""
    sleep 2
    ui_print "• More info about this module please read on mlplus official github."
    ui_print "• https://github.com/kageyuki-takeru/mlplus"
    ui_print ""
    sleep 2
    ui_print "Volume Key Selector:"
    ui_print "• Used to select options on GPU Rendering, OpenGL ES Version, and DNS Changer."
    ui_print ""
    sleep 2
    ui_print "Button Function:"
    ui_print "• Volume + (Next)"
    ui_print "• Volume - (Select)"
    ui_print ""
    sleep 2
    ui_print "Device Info..."
    sleep 1.5
    ui_print "- Model: $(getprop ro.product.manufacturer) $(getprop ro.product.model)"
    sleep 1.5
    ui_print "- Total RAM: $(free -m | grep Mem: | awk '{print $2}')MB"
    sleep 1.5
    ui_print "- OpenGL ES Version: $(getprop ro.opengles.version)"
    ui_print ""
    sleep 2
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
    unzip -o "$ZIPFILE" system.prop -d $MODPATH >&2
    unzip -o "$ZIPFILE" uninstall.sh -d $MODPATH >&2
    ui_print ""
    sleep 2
    
    . $MODPATH/addon/Volume-Key-Selector/install.sh
    
    ui_print "Select GPU Rendering..."
    ui_print " 1. OpenGL ES"
    ui_print " 2. OpenGL Skia"
    ui_print " 3. Vulkan Skia"
    ui_print ""
    sleep 1
    
    A=1
    while true; do
        ui_print "$A"
        if $VKSEL; then
            A=$((A + 1))
        else
            break
        fi
        if [ $A -gt 3 ]; then
            A=1
        fi
    done
    ui_print "Selected: $A"
    case $A in
        1 ) TEXT1="OpenGL ES"; sed -i '/debug.hwui.renderer/s/.*/debug.hwui.renderer=opengl/' $MODPATH/system.prop;;
        2 ) TEXT1="OpenGL Skia"; sed -i '/debug.hwui.renderer/s/.*/debug.hwui.renderer=skiagl/' $MODPATH/system.prop;;
        3 ) TEXT1="Vulkan Skia"; sed -i '/debug.hwui.renderer/s/.*/debug.hwui.renderer=skiavk/' $MODPATH/system.prop;;
    esac
    ui_print "- $TEXT1"
    ui_print ""
    sleep 1.5
    
    ui_print "Select OpenGL ES Version..."
    ui_print " 1. OpenGL ES 3.0"
    ui_print " 2. OpenGL ES 3.1"
    ui_print " 3. OpenGL ES 3.2"
    ui_print ""
    sleep 1
    
    B=1
    while true; do
        ui_print "$B"
        if $VKSEL; then
            B=$((B + 1))
        else
            break
        fi
        if [ $B -gt 3 ]; then
            B=1
        fi
    done
    ui_print "Selected: $B"
    case $B in
        1 ) TEXT2="OpenGL ES 3.0"; sed -i '/ro.opengles.version/s/.*/ro.opengles.version=196608/' $MODPATH/system.prop;;
        2 ) TEXT2="OpenGL ES 3.1"; sed -i '/ro.opengles.version/s/.*/ro.opengles.version=196609/' $MODPATH/system.prop;;
        3 ) TEXT2="OpenGL ES 3.2"; sed -i '/ro.opengles.version/s/.*/ro.opengles.version=196610/' $MODPATH/system.prop;;
    esac
    ui_print "- $TEXT2"
    ui_print ""
    sleep 1.5
    
    ui_print "Select Default DNS..."
    ui_print " 1. Cloudflare DNS"
    ui_print " 2. Google DNS"
    ui_print ""
    sleep 1
    
    C=1
    while true; do
        ui_print "$C"
        if $VKSEL; then
            C=$((C + 1))
        else
            break
        fi
        if [ $C -gt 3 ]; then
            C=1
        fi
    done
    ui_print "Selected: $C"
    case $C in
        1 ) TEXT3="Cloudflare DNS"; sed -i '/nameserver1/s/.*/nameserver 1.1.1.1/' $MODPATH/system/etc/resolv.conf; sed -i '/nameserver2/s/.*/nameserver 1.0.0.1/' $MODPATH/system/etc/resolv.conf; sed -i '/resetprop net.dns1/s/.*/resetprop net.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.dns2/s/.*/resetprop net.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.eth0.dns1/s/.*/resetprop net.eth0.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.eth0.dns2/s/.*/resetprop net.eth0.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.ppp0.dns1/s/.*/resetprop net.ppp0.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.ppp0.dns2/s/.*/resetprop net.ppp0.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet0.dns1/s/.*/resetprop net.rmnet0.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet0.dns2/s/.*/resetprop net.rmnet0.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet1.dns1/s/.*/resetprop net.rmnet1.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet1.dns2/s/.*/resetprop net.rmnet1.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.pdpbr1.dns1/s/.*/resetprop net.pdpbr1.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.pdpbr1.dns2/s/.*/resetprop net.pdpbr1.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.lte.dns1/s/.*/resetprop net.lte.dns1 1.1.1.1/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.lte.dns2/s/.*/resetprop net.lte.dns2 1.0.0.1/' $MODPATH/post-fs-data.sh; sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.0.0.1:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.0.0.1:53/' $MODPATH/service.sh; sed -i '/net.dns1/s/.*/net.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.dns2/s/.*/net.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.eth0.dns1/s/.*/net.eth0.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.eth0.dns2/s/.*/net.eth0.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.ppp0.dns1/s/.*/net.ppp0.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.ppp0.dns2/s/.*/net.ppp0.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns1/s/.*/net.rmnet0.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns2/s/.*/net.rmnet0.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns1/s/.*/net.rmnet1.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns2/s/.*/net.rmnet1.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns1/s/.*/net.pdpbr1.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns2/s/.*/net.pdpbr1.dns2=1.0.0.1/' $MODPATH/system.prop; sed -i '/net.lte.dns1/s/.*/net.lte.dns1=1.1.1.1/' $MODPATH/system.prop; sed -i '/net.lte.dns2/s/.*/net.lte.dns2=1.0.0.1/' $MODPATH/system.prop;;
        2 ) TEXT3="Google DNS"; sed -i '/nameserver1/s/.*/nameserver 8.8.8.8/' $MODPATH/system/etc/resolv.conf; sed -i '/nameserver2/s/.*/nameserver 8.8.4.4/' $MODPATH/system/etc/resolv.conf; sed -i '/resetprop net.dns1/s/.*/resetprop net.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.dns2/s/.*/resetprop net.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.eth0.dns1/s/.*/resetprop net.eth0.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.eth0.dns2/s/.*/resetprop net.eth0.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.ppp0.dns1/s/.*/resetprop net.ppp0.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.ppp0.dns2/s/.*/resetprop net.ppp0.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet0.dns1/s/.*/resetprop net.rmnet0.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet0.dns2/s/.*/resetprop net.rmnet0.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet1.dns1/s/.*/resetprop net.rmnet1.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.rmnet1.dns2/s/.*/resetprop net.rmnet1.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.pdpbr1.dns1/s/.*/resetprop net.pdpbr1.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.pdpbr1.dns2/s/.*/resetprop net.pdpbr1.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.lte.dns1/s/.*/resetprop net.lte.dns1 8.8.8.8/' $MODPATH/post-fs-data.sh; sed -i '/resetprop net.lte.dns2/s/.*/resetprop net.lte.dns2 8.8.4.4/' $MODPATH/post-fs-data.sh; sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.4.4:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.4.4:53/' $MODPATH/service.sh; sed -i '/net.dns1/s/.*/net.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.dns2/s/.*/net.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.eth0.dns1/s/.*/net.eth0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.eth0.dns2/s/.*/net.eth0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.ppp0.dns1/s/.*/net.ppp0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.ppp0.dns2/s/.*/net.ppp0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns1/s/.*/net.rmnet0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns2/s/.*/net.rmnet0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns1/s/.*/net.rmnet1.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns2/s/.*/net.rmnet1.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns1/s/.*/net.pdpbr1.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns2/s/.*/net.pdpbr1.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.lte.dns1/s/.*/net.lte.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.lte.dns2/s/.*/net.lte.dns2=8.8.4.4/' $MODPATH/system.prop;;
        3 ) TEXT3="Disable (Without DNS)"; rm -rf $MODPATH/system 2>/dev/null; rm -f $MODPATH/post-fs-data.sh 2>/dev/null; sed -i '/# DNS Changer/s/.*/# DNS Changer (disable)/' $MODPATH/service.sh; sed -i '/iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/# iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/# iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.4.4:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination :53/s/.*/# iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53/' $MODPATH/service.sh; sed -i '/iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination :53/s/.*/# iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.4.4:53/' $MODPATH/service.sh; sed -i '/# DNS Changer/s/.*/# DNS Changer (disable)/' $MODPATH/system.prop; sed -i '/net.dns1/s/.*/# net.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.dns2/s/.*/# net.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.eth0.dns1/s/.*/# net.eth0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.eth0.dns2/s/.*/# net.eth0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.ppp0.dns1/s/.*/# net.ppp0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.ppp0.dns2/s/.*/# net.ppp0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns1/s/.*/# net.rmnet0.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.rmnet0.dns2/s/.*/# net.rmnet0.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns1/s/.*/# net.rmnet1.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.rmnet1.dns2/s/.*/# net.rmnet1.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns1/s/.*/# net.pdpbr1.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.pdpbr1.dns2/s/.*/# net.pdpbr1.dns2=8.8.4.4/' $MODPATH/system.prop; sed -i '/net.lte.dns1/s/.*/# net.lte.dns1=8.8.8.8/' $MODPATH/system.prop; sed -i '/net.lte.dns2/s/.*/# net.lte.dns2=8.8.4.4/' $MODPATH/system.prop;;
    esac
    ui_print "- $TEXT3"
    ui_print ""
    sleep 1.5
    
    rm -rf $MODPATH/addon 2>/dev/null
    
    ui_print "- Settings module"
    sed -i '/ro.product.brand/s/.*/ro.product.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.manufacturer/s/.*/ro.product.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.marketname/s/.*/ro.product.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.model/s/.*/ro.product.model=M2102K1G/' $MODPATH/system.prop;
    sed -i '/ro.product.odm.brand/s/.*/ro.product.odm.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.odm.manufacturer/s/.*/ro.product.odm.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.odm.marketname/s/.*/ro.product.odm.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=M2102K1G/' $MODPATH/system.prop;
    sed -i '/ro.product.product.brand/s/.*/ro.product.product.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.product.manufacturer/s/.*/ro.product.product.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.product.marketname/s/.*/ro.product.product.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.product.model/s/.*/ro.product.product.model=M2102K1G/' $MODPATH/system.prop;
    sed -i '/ro.product.system.brand/s/.*/ro.product.system.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.system.manufacturer/s/.*/ro.product.system.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.system.marketname/s/.*/ro.product.system.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.system.model/s/.*/ro.product.system.model=M2102K1G/' $MODPATH/system.prop;
    sed -i '/ro.product.system_ext.brand/s/.*/ro.product.system_ext.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.system_ext.manufacturer/s/.*/ro.product.system_ext.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.system_ext.marketname/s/.*/ro.product.system_ext.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=M2102K1G/' $MODPATH/system.prop;
    sed -i '/ro.product.vendor.brand/s/.*/ro.product.vendor.brand=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.vendor.manufacturer/s/.*/ro.product.vendor.manufacturer=Xiaomi/' $MODPATH/system.prop;
    sed -i '/ro.product.vendor.marketname/s/.*/ro.product.vendor.marketname=Mi 11 Ultra/' $MODPATH/system.prop;
    sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=M2102K1G/' $MODPATH/system.prop;
    sleep 2
    
    ui_print "- Set permissions"
    set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm $MODPATH/system/etc/resolv.conf 0 0 0644 0644
    sleep 1.5
}

if [ ! "$SKIPUNZIP" = "0" ]; then
    set -x
    PRINT
    EXEC
else
    set +x
    abort
fi
