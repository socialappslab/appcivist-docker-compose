#!/bin/bash
cd /home/appcivist/production/appcivist-platform/conf/
cp local.sample.conf local.conf
cp play-authenticate/mine.sample.conf play-authenticate/mine.conf
cp play-authenticate/smtp.sample.conf play-authenticate/smtp.conf
cd /home/appcivist/production/appcivist-platform/
./activator stage && /etc/init.d/appcivist-backend start