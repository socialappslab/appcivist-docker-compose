#!/bin/bash
HOME_DIR='/home/yohanna/desarrollo/'
echo 'pulling backend'
cd ${HOME_DIR}
cd appcivist-platform
git checkout master
git pull origin master
cd ..
echo 'pulling front end'
cd appcivist-pb-client
git checkout master
git pull origin master
cd ..
echo 'pulling voting api'
cd appcivist-voting-api
git checkout master
git pull origin master
cd ..
cd appcivist-docker
docker-compose build
echo 'Up db'
docker-compose up -d db
echo 'Up mongo'
docker-compose up -d mongo
while [ $(docker inspect -f '{{.State.Running}}' db) = "false" ]
do
echo 'Starting db'
sleep 10
done
echo 'Up etherpad'
docker-compose up -d etherpad-lite
echo 'Up rabbitmq'
docker-compose up -d rabbitmq
echo 'Up appcivist-voting-api'
docker-compose up -d appcivist-voting-api
echo 'Up appcivist-usnb'
docker-compose up -d appcivist-usnb
echo 'Up appcivist-plataform'
docker-compose up -d appcivist-plataform
echo 'Up appcivist-pb-client'
docker-compose up -d appcivist-pb-client