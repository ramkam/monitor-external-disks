#!/bin/bash

# Is run via launchdaemon
# Triggered when a disk is mounted

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; 
ts="$(date "+%Y-%m-%d %H:%M:%S")";
logusage="$workdir/log_usage.txt"
diskdescdir="$workdir/diskdesc"
mkdir -p "$diskdescdir";


# Log disk usage & Update disk description
df -h | grep "Volumes" | grep -v "MobileBackups" | while read ll; do 
	b="$(echo "$ll" | awk '{print $2"|"$3"|"$4"|"$5}')"
	a="$(echo "${ll:65}")"
	l="$b|$a"
	mountpoint="$(echo $l | awk -F"|" '{print $5}')";
	echo "$mountpoint";
	uuid="$(diskutil info "$mountpoint" | grep UUID | awk '{print $3}')"
	protocol="$(diskutil info "$mountpoint" | grep -iF "Protocol:" | head -1 | awk '{print $2" "$3" "$4}')"
	diskutil info "$mountpoint" > "$diskdescdir/Disk_${protocol}_${uuid}.txt"
	echo "$ts|$protocol|$uuid|$l" >> "$logusage"
done
	
