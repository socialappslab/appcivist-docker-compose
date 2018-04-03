#!/bin/bash
echo 'Pulling develop branch of appcivist-pb-client'
cd /home/appcivist/production/appcivist-pb-client
git checkout develop
git pull origin develop
cd /home/appcivist/production/appcivist-docker-compose
echo 'Restarting Docker instance'
docker-compose stop appcivist-pb-client
docker-compose up -d appcivist-pb-client
echo 'DONE!'
