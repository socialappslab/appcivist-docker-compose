#!/bin/bash
cd /home/appcivist/production/appcivist-voting-api
gem install rails -v 4.2.5
gem install bundler
bundle install
sh /etc/init.d/appcivist-voting-api.sh start