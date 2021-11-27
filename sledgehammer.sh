#!/bin/bash
apt-get install dnsutils --assume-yes
server=$(nslookup seed.helium.io | grep "Address: " | sed "s/Address: //")

for s in $server; do
  sudo docker exec miner miner peer connect /ip4/$s/tcp/2154
done
