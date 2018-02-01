#!/bin/bash
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