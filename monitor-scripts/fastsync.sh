#!/bin/bash
status=$(</var/dashboard/statuses/fastsync)
block=$(wget -qO- https://helium-snapshots.nebra.com/latest.json | grep -Po '"'"height"'"\s*:\s*\K([^,]*)')

if [[ $status == 'true' ]]
then
  sudo wget "https://helium-snapshots.nebra.com/snap-$block" -O /home/pi/hnt/miner/snap/snap-latest
  sudo docker exec miner miner snapshot load /var/data/snap/snap-latest
  pid=$!
  echo $pid > /var/dashboard/statuses/fastsync
else
  if [[ $status != 'false' ]]
  then
    if ps -p $status > /dev/null
    then
      echo $status > /var/dashboard/statuses/fastsync
    else
      echo 'false' > /var/dashboard/statuses/fastsync
    fi
  fi
fi
