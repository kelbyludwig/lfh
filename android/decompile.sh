#!/bin/bash

APKS=$(ls *.apk)
for APK in $APKS
do 
	d2j-dex2jar $APK
done

JARS=$(ls *.jar)
for JAR in $JARS
do
	procyon-decompiler --output-directory $JAR-decompiled $JAR
done
