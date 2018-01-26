#!/bin/bash
gem install bundler --pre
cd /home/appcivist/production/appcivist-voting-api
bundle install
sudo sh /etc/init.d/appcivist-voting-api.sh start