#!/bin/bash

usage() { echo "Usage: $0 -c <path-to-cert>" 1>&2; exit 1; }
dne() { echo "Error: specified file does not exist" 1>&2; exit 1; }

if [ $# -ne 2 ]; then
	   usage;
fi

while getopts ":c:" opt; do
	case $opt in
		c)
			if [[ -e $OPTARG ]]; then
				FILENAME=$OPTARG
				HASH=$(openssl x509 -inform DER -hash -in $OPTARG | head -1)
				cat $FILENAME > $HASH.0
				openssl x509 -inform DER -text -in $FILENAME -out /dev/null >> $HASH.0
				adb push *.0 /sdcard/
				adb shell "su -c 'mount -o remount,rw /system'"
				adb shell "su -c 'cp /sdcard/*.0 /system/etc/security/cacerts/'"
				adb shell "su -c 'chmod 644 /system/etc/security/cacerts/*.0'"
                    		read -p "Certificate should be installed. A restart is necessary. Restart the device now? [y/n]" -n 1 -r
                    		echo    
                    		if [[ $REPLY =~ ^[Yy]$ ]]; then
                    		    adb reboot
                    		fi

			else
				dne
			fi
			;;
		\?)
			usage
			;;
		:)
			usage
			;;
	esac
done
