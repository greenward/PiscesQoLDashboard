#!/bin/bash
wlan=$(</var/dashboard/services/wifi)

ethernet=$(ip address show eth0 | grep "inet " | egrep -o "inet [^.]+.[^.]+.[^.]+.[^/]+" | sed -e "s/inet //")
ethernet="eth0: "$ethernet
if [[ $wlan != 'disabled' ]]; then
  wifi_addr=$(ip address show wlan0 | grep "inet " | egrep -o "inet [^.]+.[^.]+.[^.]+.[^/]+" | sed -e "s/inet //")
  wifi="wlan0: "$wifi_addr
fi

echo $ethernet > /var/dashboard/statuses/local-ip

if [[ $wlan != 'disabled' ]] && [[ ! -z $wifi_addr ]]; then
  echo " / " $wifi >> /var/dashboard/statuses/local-ip
fi
