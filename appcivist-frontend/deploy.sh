#!/bin/bash
source ~/.bashrc
cd /home/appcivist/production/appcivist-pb-client
npm install -f
bower -f update appcivist-patterns
grunt build -f
rm -rf /var/www/html/appcivist-pb/*
cp -rf dist/* /var/www/html/appcivist-pb
sudo apachectl -D FOREGROUND