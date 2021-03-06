#!/bin/bash

echo -n "#Architecture: "; uname -a
echo -n "#CPU physical : "; grep -c processor /proc/cpuinfo
echo -n "#vCPU : "; cat /proc/cpuinfo | grep processor | wc -l
echo -n "#Memory Usage: "; free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
echo -n "#Disk Usage: "; df -m | awk 'NR==4{printf "%d", $3}' && df -h | awk 'NR==4{printf"/%dGb (%d%%)\n", $2, $3*100/$2}'
echo -n "#CPU load: "; top -bn1 | grep load | awk '{printf "%.2f%%\n", $11}'
echo -n "#Last boot: "; who | awk '{printf"%s %s\n", $3, $4}'
echo -n "#LVM use: "; if lsblk | grep -q lvm; then echo "yes"; else echo "no"; fi
echo -n "#Connexions TCP : "; netstat -a | grep tcp | grep ESTABLISHED | awk '{print $6}' | sort | uniq -c
echo -n "#User log : "; w | awk 'NR==1{printf"%d\n", $5}'
echo -n "#Network : "; hostname -I | awk '{printf"IP %s ", $1}' && ip addr | awk 'NR==8{printf"(%s) \n", $2}'
echo -n "#Sudo : "; grep -c "COMMAND=" /var/log/sudo/log
printf "\n"
