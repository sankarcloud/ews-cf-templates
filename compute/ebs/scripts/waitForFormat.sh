#!/usr/bin/env bash

if [ "$#" -gt 2 ]; then
    echo "Usage: waitForFormat device_name [gpt|msdos]"
    exit 1
fi

LABEL=gpt

case "$2" in
    msdos)
	LABEL=msdos
	;;
    *)
	LABEL=gpt
	;;
esac

while true; do
    if [ `fdisk -l /dev/$1 | wc -l 2>/dev/null` -gt 0 ]; then
	parted -a optimal -s -- /dev/$1 mklabel $LABEL mkpart primary 0% 100%;
	exit 0
    fi
done
