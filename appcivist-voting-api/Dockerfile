FROM ruby:2.3.0
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-voting-api

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update
RUN apt-get install -y sudo nodejs vim
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN chown -R appcivist:appcivist ~/.gem
RUN chown -R appcivist:appcivist /usr/local/bundle
WORKDIR ${PROJECT_HOME}
ADD appcivist-voting-api.sh /etc/init.d/appcivist-voting-api.sh
RUN chmod 777 /etc/init.d/appcivist-voting-api.sh
ADD deploy.sh /tmp/deploy.sh
RUN chmod 777 /tmp/deploy.sh
USER appcivist
EXPOSE 5000

CMD sh /tmp/deploy.sh
