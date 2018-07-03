#!/bin/bash
export `cat .env`
cd /home/appcivist/production/appcivist-platform/conf/
if [ -e local.conf ]
then
    echo "Using existing conf/local.conf"
else
    echo "Using sample conf/local.conf"
    cp local.sample.conf local.conf
fi
if [ -e play-authenticate/mine.local.conf ]
then
    echo "Using existing play-authenticate/mine.local.conf"
else
    echo "Using sample play-authenticate/mine.local.conf"
    cp play-authenticate/mine.sample.conf play-authenticate/mine.local.conf
fi
if [ -e play-authenticate/smtp.local.conf ]
then
    echo "Using existing play-authenticate/smtp.local.conf"
else
    echo "Using sample play-authenticate/smtp.local.conf"
    cp play-authenticate/smtp.sample.conf play-authenticate/smtp.local.conf
fi
cd /home/appcivist/production/appcivist-platform/
./activator stage && /etc/init.d/appcivist-backend start
