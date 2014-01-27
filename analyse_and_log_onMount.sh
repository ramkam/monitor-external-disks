#!/bin/bash

# Is run via launchdaemon
# Triggered when a disk is mounted

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; 
ts="$(date "+%Y-%m-%d %H:%M:%S")";
logusage="$workdir/log_usage.txt"

# Log disk usage
df -h | grep "Volumes" | grep -v "MobileBackups" | awk '{print $2"|"$3"|"$4"|"$5"|"$6}' | while read l; do 
	echo "$ts|$l" >> "$logusage"
done
	
