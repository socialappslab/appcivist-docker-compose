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
a2enconf fqdn

a2ensite 000-default.vhost.conf
service apache2 reload
a2ensite 111-appcivist-pb.conf
service apache2 reload
a2ensite 222-etherpad.conf
service apache2 reload
a2ensite 333-appcivist-platform.conf
service apache2 reload
sudo service apache2 restart && tail -f /dev/null