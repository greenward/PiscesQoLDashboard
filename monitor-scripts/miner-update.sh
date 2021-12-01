#!/bin/bash
service=$(cat /var/dashboard/services/miner-update | tr -d '\n')
version=$(cat /var/dashboard/statuses/latest_miner_version | tr -d '\n')
version_date=$(cat /var/dashboard/statuses/latest_miner_version | sed 's/miner-arm64_//')

if [[ $service == 'start' ]]; then
  echo 'running' > /var/dashboard/services/miner-update
  echo 'Stopping currently running docker...' > /var/dashboard/logs/miner-update.log
  docker stop miner >> /var/dashboard/logs/miner-update.log
  currentdockerstatus=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
  if [[ $currentdockerstatus =~ 'Exited' || $currentdockerstatus == '' ]]; then
    echo 'Backing up current config...' >> /var/dashboard/logs/miner-update.log
    currentconfig=$(sudo docker inspect miner | grep sys.config | grep -Po '"Source": ".*\/sys.config' | sed 's/"Source": "//' | sed -n '1p')
    mkdir /home/pi/hnt/miner/configs
    mkdir /home/pi/hnt/miner/configs/previous_configs
    currentversion=$(docker ps -a -f name=miner --format "{{ .Image }}" | grep -Po 'miner: *.+' | sed 's/miner://')
    cp "$currentconfig" "/home/pi/hnt/miner/configs/previous_configs/$currentversion.config" >> /var/dashboard/logs/miner-update.log
    echo 'Acquiring the latest config from Helium version tag ...' >> /var/dashboard/logs/miner-update.log
    curl -s "https://raw.githubusercontent.com/helium/miner/$version_date/config/sys.config" | sed 's/i2c-1/i2c-0/' | sed 's_https://snapshots.helium.wtf/mainnet_https://helium-snapshots.nebra.com_' | sudo tee /home/pi/hnt/miner/configs/sys.config
    echo 'Saved latest config file ...' >> /var/dashboard/logs/miner-update.log
    echo 'Removing currently running docker...' >> /var/dashboard/logs/miner-update.log
    docker rm miner
    echo 'Acquiring and starting latest docker version...' >> /var/dashboard/logs/miner-update.log
    docker image pull quay.io/team-helium/miner:$version >> /var/dashboard/logs/miner-update.log
    docker run -d --init --ulimit nofile=64000:64000 --restart always --publish 1680:1680/udp --publish 44158:44158/tcp -e REGION_OVERRIDE=EU868 -e OTP_VERSION=23.3.4.7 -e REBAR3_VERSION=3.16.1 --name miner --mount type=bind,source=/home/pi/hnt/miner,target=/var/data --mount type=bind,source=/home/pi/hnt/miner/log,target=/var/log/miner --device /dev/i2c-0 --net host --privileged -v /var/run/dbus:/var/run/dbus --mount type=bind,source=/home/pi/hnt/miner/configs/sys.config,target=/config/sys.config quay.io/team-helium/miner:$version >> /var/dashboard/logs/miner-update.log

    currentdockerstatus=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
    if [[ $currentdockerstatus =~ 'Up' ]]; then
      echo 'Removing old docker firmware image to free some space ...' >> /var/dashboard/logs/miner-update.log
      docker rmi $(docker images -q quay.io/team-helium/miner:$currentversion)
      echo 'stopped' > /var/dashboard/services/miner-update
      echo $version > /var/dashboard/statuses/current_miner_version
      echo "DISTRIB_RELEASE=$(echo $version | sed -e 's/miner-arm64_//' | sed -e 's/_GA//')" > /etc/lsb_release
      echo 'Update complete.' >> /var/dashboard/logs/miner-update.log
    else
      echo 'stopped' > /var/dashboard/services/miner-update
      echo 'Miner docker failed to start.  Check logs to investigate.'
    fi  
  else
    echo 'stopped' > /var/dashboard/services/miner-update
    echo 'Error: Could not stop docker.' >> /var/dashboard/logs/miner-update.log
  fi  
fi
