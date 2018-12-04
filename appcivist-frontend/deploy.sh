#!/bin/bash
source ~/.bashrc

#!/bin/bash
cd /home/appcivist/production/appcivist-pb-client/app
if [ -e env.js ]
then
    echo "Using existing env.js"
else
    echo "Using sample env.sample.js"
    cp env.sample.js env.js
fi

sed -i -e "s/SENTRY_SECRET/$SENTRY_SECRET/g" env.js
sed -i -e "s/SENTRY_PROJECT_ID/$SENTRY_PROJECT_ID/g" env.js

chmod 777 -R /home/appcivist/production/appcivist-pb-client
cd /home/appcivist/production/appcivist-pb-client
su appcivist
npm install -g grunt-cli
npm install -g bower
gem update --system
gem install compass
gem install sass
npm install -f
grunt server
#grunt build -f
#mkdir -p /var/www/html/appcivist-pb
#cp -rf dist/* /var/www/html/appcivist-pb

