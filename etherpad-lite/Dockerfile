FROM tvelocity/etherpad-lite
RUN apt-get update
RUN apt-get install -y abiword
RUN echo "www-data ALL = NOPASSWD: /usr/bin/abiword" > /etc/sudoers
RUN npm cache clean -f
RUN npm install -g n
RUN n stable

