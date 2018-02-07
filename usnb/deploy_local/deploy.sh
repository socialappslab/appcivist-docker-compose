#!/bin/bash
rm -rf /home/appcivist/production/usnb/api-gateway/*
rm -rf /home/appcivist/production/usnb/entity-manager/*
rm -rf /home/appcivist/production/usnb/email-bindingcomponent/*
rm -rf /home/appcivist/production/usnb/facebook-bindingcomponent/*
rm -rf /home/appcivist/production/usnb/subscription-manager/*

sed -i 's/user:pass/'"$RABBITMQ_DEFAULT_USER"':'"$RABBITMQ_DEFAULT_PASS"'/g' *.js

sed -i 's/S_FACEBOOK_USER/'"$USNB_FACEBOOK_USER"'/g' facebook-bindingcomponent.ecosystem.config.js
sed -i 's/S_FACEBOOK_PASS/'"$USNB_FACEBOOK_PASSWORD"'/g' facebook-bindingcomponent.ecosystem.config.js

sed -i 's/S_EMAIL_USER/'"$USNB_EMAIL_USER"'/g' email-bindingcomponent.ecosystem.config.js
sed -i 's/S_EMAIL_PASS/'"$USNB_EMAIL_PASSWORD"'/g' email-bindingcomponent.ecosystem.config.js

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