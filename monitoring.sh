#!/bin/bash

# Script for monitoring basic laptop status

echo "*** SYSTEM CHECK ON $(date) ***"

echo -e "\n*** SYSTEM INFORMATION ***"

hostnamectl

echo -e "\n*** DISK USAGE ***"

df -h --total

echo -e "\nHome directories"

du -sch /home/*

TOTAL_USAGE=$(df -H --total | grep total | awk '{ printf "%d", $5}')

if [[ $TOTAL_USAGE -gt 70 ]]; then
    echo "WARNING! TOTAL DISK USAGE CRITICALLY HIGH!"
fi

echo -e "\n*** INSTALLED UPGRADES ***"

cat /var/log/unattended-upgrades/unattended-upgrades.log | grep "Packages that will be upgraded"

echo -e "\n*** RKHUNTER ***"

rkhunter --check --report-warnings-only
