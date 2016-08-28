wget http://www.androidtcpdump.com/download/4.7.4/tcpdump
adb push tcpdump /sdcard/tcpdump
adb shell "su -c 'mount -o remount,rw /system'"
adb shell "su -c 'cat /sdcard/tcpdump > /system/bin/tcpdump'"
adb shell "su -c 'chown root:shell /system/bin/tcpdump'"
adb shell "su -c 'chmod 754 /system/bin/tcpdump'"
adb shell "su -c 'mount -o remount,ro /system'"
adb shell "rm /sdcard/tcpdump"
rm tcpdump
