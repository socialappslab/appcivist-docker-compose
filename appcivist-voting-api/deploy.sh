#!/bin/bash
bundle install
sh /etc/init.d/appcivist-voting-api.sh start
tail -f /dev/null
