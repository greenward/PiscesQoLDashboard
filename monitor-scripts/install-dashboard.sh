#!/bin/bash
systemctl stop apache2.service
systemctl disable apache2.service

sleep 5

systemctl start nginx
systemctl enable nginx

systemctl start php-fpm.service
systemctl enable php-fpm.service
