#!/bin/bash
source ~/.bashrc
cd /home/appcivist/production/appcivist-pb-client
npm install grunt --save-dev
npm install -f 
bower install
bower -f update appcivist-patterns
grunt build -f
rm -rf /var/www/html/appcivist-pb/*
cp -rf dist/* /var/www/html/appcivist-pb
sudo service apache2 stop
sudo service apache2 start
echo "ServerName appcivist.org" | sudo tee /etc/apache2/conf-available/fqdn.conf
sudo a2enconf fqdn
sudo service apache2 reload
sudo a2ensite 000-default.conf
sudo service apache2 reload
sudo a2ensite 000-default.vhost.conf
sudo service apache2 reload
sudo a2ensite 000-default.conf
sudo service apache2 reload
sudo a2ensite 111-appcivist-pb.conf
sudo service apache2 reload
sudo a2ensite 222-etherpad.conf
sudo service apache2 reload
sudo a2ensite 333-appcivist-platform.conf
sudo service apache2 reload
sudo service apache2 restart && tail -f /dev/null
