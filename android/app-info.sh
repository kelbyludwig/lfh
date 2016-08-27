#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

usage() { echo "Usage: $0 -p <PACKAGE-name>" 1>&2; exit 1; }

if [ $# -ne 2 ]; then
	   usage;
fi

while getopts ":p:" opt; do
	case $opt in
		p)
			PACKAGES=$(adb shell pm list packages | grep -i --color=none "$OPTARG")
			if [[ $PACKAGES ]]; then
				echo -e "${RED}Matching package names and paths:${NC}"
				for PACKAGE in $PACKAGES
				do
					PACKAGE=$(echo $PACKAGE | tr -d '\n\r')
					PSUB=${PACKAGE:8}
					PACKAGEPATH=$(adb shell pm path $PSUB | tr -d '\n\r')
					PACKAGEPATH=${PACKAGEPATH:8}
					printf "%s\t%s\n" "$PSUB" "$PACKAGEPATH"
					read -p "Do you want to pull that package? [y/n]" -n 1 -r
					echo    
					if [[ $REPLY =~ ^[Yy]$ ]]; then
						echo "pulling $PACKAGEPATH"
						adb pull $PACKAGEPATH
					fi
				done
			else
				echo -e "${RED}No packages with name $OPTARG found${NC}"
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
