FROM digitallyseamless/nodejs-bower-grunt
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-pb-client

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN apt-get install -y ruby ruby-dev
RUN gem update --system
RUN gem install compass
RUN gem install sass
RUN mkdir -p ${PROJECT_HOME}
RUN mkdir -p /opt/appcivist/files
RUN chown appcivist:appcivist /opt/appcivist/files
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN apt-get install -y apache2 git
RUN mkdir /var/www/html/appcivist-pb
RUN chown appcivist:appcivist /var/www/html/appcivist-pb
ADD sites /etc/apache2/sites-available
ADD sites /etc/apache2/sites-enabled
RUN rm -rf /etc/apache2/mods-enabled
ADD mods-enabled /etc/apache2/mods-enabled
ADD modules /usr/lib/apache2/modules
ADD ssll /root/ssl
RUN chmod 777 -R /home/appcivist/production/appcivist-pb-client/
EXPOSE 8080
EXPOSE 3001
ADD deploy.sh deploy.sh
RUN chmod 777 deploy.sh
