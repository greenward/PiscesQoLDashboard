#!/bin/bash
idle=$(top -b -n 1 | grep -Po '%Cpu\(s\): *.+' | grep -Po '[0-9.]+ id,' | sed 's/id,//' | xargs)

used=$(echo "$idle" | awk '{print 100 - $1}')
echo $used > /var/dashboard/statuses/cpu
