git pull
npm install
bower update appcivist-patterns
grunt build
rm -rf /var/www/html/appcivist-pb/*
cp -rf dist/* /var/www/html/appcivist-pb
