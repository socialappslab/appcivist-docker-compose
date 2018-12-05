FROM digitallyseamless/nodejs-bower-grunt
MAINTAINER Cristhian Parra <cdparra@gmail.com>
RUN npm cache clean -f
RUN npm install -g n
RUN n stable

ENV PROJECT_HOME /home/appcivist/production/appcivist-pb-client

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN apt-get install -y ruby ruby-dev
RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN chmod 777 -R /home/appcivist/production/appcivist-pb-client/
ADD deploy.sh deploy.sh
RUN chmod 777 deploy.sh
RUN gem install haml
EXPOSE 8000
