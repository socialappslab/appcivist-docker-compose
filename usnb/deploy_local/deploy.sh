#!/bin/bash
rm -rf /home/appcivist/production/usnb/api-gateway/*
rm -rf /home/appcivist/production/usnb/entity-manager/*
rm -rf /home/appcivist/production/usnb/email-bindingcomponent/*
rm -rf /home/appcivist/production/usnb/facebook-bindingcomponent/*
rm -rf /home/appcivist/production/usnb/subscription-manager/*

pm2 deploy entity-manager.ecosystem.config.js $1 setup
pm2 deploy entity-manager.ecosystem.config.js $1
pm2 deploy email-bindingcomponent.ecosystem.config.js $1 setup
pm2 deploy email-bindingcomponent.ecosystem.config.js $1
pm2 deploy facebook-bindingcomponent.ecosystem.config.js $1 setup
pm2 deploy facebook-bindingcomponent.ecosystem.config.js $1
pm2 deploy subscription-manager.ecosystem.config.js $1 setup
pm2 deploy subscription-manager.ecosystem.config.js $1
pm2 deploy api-gateway.ecosystem.config.js $1 setup
pm2 deploy api-gateway.ecosystem.config.js $1