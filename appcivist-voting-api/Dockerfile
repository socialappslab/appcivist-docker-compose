FROM ruby:2.3.0
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-voting-api

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y sudo nodejs
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN chown -R appcivist:appcivist ~/.gem
RUN chown -R appcivist:appcivist /usr/local/bundle
ADD appcivist-voting-api.sh /etc/init.d/appcivist-voting-api.sh
RUN chmod 777 /etc/init.d/appcivist-voting-api.sh
ADD deploy.sh deploy.sh
RUN chmod 777 deploy.sh
EXPOSE 5001
RUN apt-get install -y vim
USER appcivist
