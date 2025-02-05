#!/bin/bash
systemctl stop nginx
systemctl disable nginx
apt-get --assume-yes remove nginx php-fpm

systemctl stop bt-check.timer
systemctl stop bt-service-check.timer
systemctl stop clean-memory.timer
systemctl stop clear-blockchain-check.timer
systemctl stop cpu-check.timer
systemctl stop external-ip-check.timer
systemctl stop fastsync-check.timer
systemctl stop gps-check.timer
systemctl stop helium-status-check.timer
systemctl stop infoheight-check.timer
systemctl stop local-ip-check.timer
systemctl stop miner-check.timer
systemctl stop miner-service-check.timer
systemctl stop miner-version-check.timer
systemctl stop password-check.timer
systemctl stop peer-list-check.timer
systemctl stop pf-check.timer
systemctl stop pf-service-check.timer
systemctl stop pubkeys-check.timer
systemctl stop reboot-check.timer
systemctl stop sn-check.timer
systemctl stop temp-check.timer
systemctl stop update-check.timer
systemctl stop update-miner-check.timer
systemctl stop wifi-check.timer
systemctl stop wifi-config-check.timer
systemctl stop wifi-service-check.timer

systemctl disable bt-check.timer
systemctl disable bt-service-check.timer
systemctl disable clean-memory.timer
systemctl disable clear-blockchain-check.timer
systemctl disable cpu-check.timer
systemctl disable external-ip-check.timer
systemctl disable fastsync-check.timer
systemctl disable gps-check.timer
systemctl disable helium-status-check.timer
systemctl disable infoheight-check.timer
systemctl disable local-ip-check.timer
systemctl disable miner-check.timer
systemctl disable miner-service-check.timer
systemctl disable miner-version-check.timer
systemctl disable password-check.timer
systemctl disable peer-list-check.timer
systemctl disable pf-check.timer
systemctl disable pf-service-check.timer
systemctl disable pubkeys-check.timer
systemctl disable reboot-check.timer
systemctl disable sn-check.timer
systemctl disable temp-check.timer
systemctl disable update-check.timer
systemctl disable update-miner-check.timer
systemctl disable wifi-check.timer
systemctl disable wifi-config-check.timer
systemctl disable wifi-service-check.timer

rm -rf /etc/systemd/system/bt-check.timer
rm -rf /etc/systemd/system/bt-check.service
rm -rf /etc/systemd/system/bt-service-check.service
rm -rf /etc/systemd/system/bt-service-check.timer
rm -rf /etc/systemd/system/clean-memory.timer
rm -rf /etc/systemd/system/clean-memory.service
rm -rf /etc/systemd/system/clear-blockchain-check.timer
rm -rf /etc/systemd/system/clear-blockchain-check.service
rm -rf /etc/systemd/system/cpu-check.timer
rm -rf /etc/systemd/system/cpu-check.service
rm -rf /etc/systemd/system/external-ip-check.service
rm -rf /etc/systemd/system/external-ip-check.timer
rm -rf /etc/systemd/system/fastsync-check.service
rm -rf /etc/systemd/system/fastsync-check.timer
rm -rf /etc/systemd/system/gps-check.service
rm -rf /etc/systemd/system/gps-check.timer
rm -rf /etc/systemd/system/helium-status-check.service
rm -rf /etc/systemd/system/helium-status-check.timer
rm -rf /etc/systemd/system/infoheight-check.service
rm -rf /etc/systemd/system/infoheight-check.timer
rm -rf /etc/systemd/system/install-dashboard.service
rm -rf /etc/systemd/system/local-ip-check.service
rm -rf /etc/systemd/system/local-ip-check.timer
rm -rf /etc/systemd/system/miner-check.service
rm -rf /etc/systemd/system/miner-check.timer
rm -rf /etc/systemd/system/miner-service-check.service
rm -rf /etc/systemd/system/miner-service-check.timer
rm -rf /etc/systemd/system/miner-version-check.timer
rm -rf /etc/systemd/system/miner-version-check.service
rm -rf /etc/systemd/system/password-check.service
rm -rf /etc/systemd/system/password-check.timer
rm -rf /etc/systemd/system/peer-list-check.service
rm -rf /etc/systemd/system/peer-list-check.timer
rm -rf /etc/systemd/system/pf-check.service
rm -rf /etc/systemd/system/pf-check.timer
rm -rf /etc/systemd/system/pf-service-check.service
rm -rf /etc/systemd/system/pf-service-check.timer
rm -rf /etc/systemd/system/pubkeys-check.service
rm -rf /etc/systemd/system/pubkeys-check.timer
rm -rf /etc/systemd/system/reboot-check.service
rm -rf /etc/systemd/system/reboot-check.timer
rm -rf /etc/systemd/system/sn-check.service
rm -rf /etc/systemd/system/sn-check.timer
rm -rf /etc/systemd/system/temp-check.service
rm -rf /etc/systemd/system/temp-check.timer
rm -rf /etc/systemd/system/update-check.service
rm -rf /etc/systemd/system/update-check.timer
rm -rf /etc/systemd/system/update-miner-check.timer
rm -rf /etc/systemd/system/update-miner-check.service
rm -rf /etc/systemd/system/wifi-check.service
rm -rf /etc/systemd/system/wifi-check.timer
rm -rf /etc/systemd/system/wifi-config-check.service
rm -rf /etc/systemd/system/wifi-config-check.timer
rm -rf /etc/systemd/system/wifi-service-check.service
rm -rf /etc/systemd/system/wifi-service-check.timer

rm -rf /var/dashboard
rm -rf /etc/monitor-scripts
rm -rf /etc/ssl/certs/nginx-selfsigned.crt
rm -rf /etc/ssl/private/nginx-selfsigned.key
rm -rf /tmp/latest.tar.gz 
rm -rf /tmp/dashboardinstall

systemctl start apache2.service
systemctl enable apache2.service
