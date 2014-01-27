#!/bin/bash

# Is run via launchdaemon
# Triggered when a disk is mounted

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; 
ts="$(date "+%Y-%m-%d %H:%M:%S")";
logusage="$workdir/log_usage.txt"
diskdescdir="$workdir/diskdesc"
mkdir -p "$diskdescdir";


# Log disk usage & Update disk description
df -h | grep "Volumes" | grep -v "MobileBackups" | awk '{print $2"|"$3"|"$4"|"$5"|"$6}' | while read l; do 
	mountpoint="$(echo $l | awk -F"|" '{print $5}')";
	uuid="$(diskutil info "$mountpoint" | grep UUID | awk '{print $3}')"
	diskutil info "$mountpoint" > "$diskdescdir/$uuid.txt"
	echo "$ts|$uuid|$l" >> "$logusage"
done
	
