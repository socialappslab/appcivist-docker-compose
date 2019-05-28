#!/bin/bash
cd /home/appcivist/production/appcivist-voting-api
gem install rails -v 4.2.7.1
gem install bundler -v 1.3.0
gem install pg
bundle install
bundle update
sh /etc/init.d/appcivist-voting-api.sh start && tail -f /dev/null
