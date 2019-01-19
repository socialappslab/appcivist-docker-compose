FROM ruby:2.5
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-pb-client

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update && apt-get install -y sudo nodejs
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN chmod 777 -R /home/appcivist/production/appcivist-pb-client/
WORKDIR ${PROJECT_HOME}

RUN npm install -g bower
RUN npm install -g grunt-cli
RUN gem update --system
RUN gem install compass
RUN gem install sass
RUN gem install haml
ADD deploy.sh /tmp/deploy.sh
RUN chmod 777 /tmp/deploy.sh
USER appcivist
CMD sh /tmp/deploy.sh
