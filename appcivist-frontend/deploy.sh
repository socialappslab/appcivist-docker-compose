#!/bin/bash
source ~/.bashrc
cd /home/appcivist/production/appcivist-pb-client
npm install grunt --save-dev
npm install -f 
bower install
bower -f update appcivist-patterns
grunt build -f
mkdir -p /var/www/html/appcivist-pb
cp -rf dist/* /var/www/html/appcivist-pb

