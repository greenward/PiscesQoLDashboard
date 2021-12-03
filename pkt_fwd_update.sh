#!/bin/bash

wget --no-cache https://raw.githubusercontent.com/greenward/PiscesQoLDashboard/main/green_packet_v2.0.1.tgz -O /tmp/green_packet_v2.0.1.tgz

tar -xzf /tmp/green_packet_v2.0.1.tgz -C /home/pi/hnt/paket
if ! test -f /home/pi/api/tool/onPacket.sh.orig; then
  cp /home/pi/api/tool/onPacket.sh /home/pi/api/tool/onPacket.sh.orig
fi
sed -i 's|/home/pi/hnt/paket/paket/packet_forwarder/|/home/pi/hnt/paket/green_packet/|' /home/pi/api/tool/onPacket.sh
kill $(ps ax | grep './lora_pkt_fwd' | grep -v 'grep' | awk '{print $1}')

bash /home/pi/api/tool/onPacket.sh > /dev/null 2>&1

rm /tmp/green_packet_v2.0.1.tgz
