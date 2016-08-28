tar xvf strace-4.8-arm-bin.tgz
adb shell "mkdir /sdcard/strace"
adb push ./data/local/bin/* /sdcard/strace
adb shell "su -c 'mount -o remount,rw /system'"
adb shell "su -c 'cat /sdcard/strace/strace > /system/bin/strace'"
adb shell "su -c 'cat /sdcard/strace/strace-graph > /system/bin/strace-graph'"
adb shell "su -c 'cat /sdcard/strace/strace-log-merge > /system/bin/strace-log-merge'"
adb shell "su -c 'chown root:shell /system/bin/strace*'"
adb shell "su -c 'chmod 754 /system/bin/strace*'"
adb shell "su -c 'mount -o remount,ro /system'"
adb shell "rm -rf /sdcard/strace"
rm -rf ./data
