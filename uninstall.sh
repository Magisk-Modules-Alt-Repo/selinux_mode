#!/system/bin/sh
MODDIR=${0%/*}

# Delete Activity Manager Tweak and use default settings
settings delete global activity_manager_constants
