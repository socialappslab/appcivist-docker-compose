#!/bin/bash
source ~/.bashrc
cd /home/appcivist/production/appcivist-pb-client
npm install grunt --save-dev
npm install -f
bower -f update appcivist-patterns
grunt build -f
rm -rf /var/www/html/appcivist-pb/*
cp -rf dist/* /var/www/html/appcivist-pb
echo "ServerName testappcivist.org" | sudo tee /etc/apache2/conf-available/fqdn.conf
sudo service apache2 stop
sudo service apache2 start && tail -f /dev/null