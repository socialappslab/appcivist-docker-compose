FROM httpd:2.4
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PRODUCTION_HOME /home/appcivist/production
ENV PROJECT_HOME /home/appcivist/production/appcivist-pb-client

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN mkdir /etc/sudoers.d
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN mkdir -p ${PRODUCTION_HOME}

# Install dependencies

RUN apt-get clean autoclean
RUN apt-get -f install
RUN apt-get autoremove

RUN apt-get update && \
    apt-get install -y git build-essential curl sudo

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

RUN apt-get install nodejs


RUN npm install -g bower grunt-cli

RUN apt-get install -y ruby ruby-dev
RUN gem update --system
RUN gem install compass
RUN gem install sass

RUN chown appcivist:appcivist ${PRODUCTION_HOME}
RUN apt-get install -y apache2
RUN mkdir /var/www/html/appcivist-pb
RUN chown appcivist:appcivist /var/www/html/appcivist-pb
USER appcivist
WORKDIR ${PRODUCTION_HOME}
#clone the project, set permissions and get the last changes
RUN git clone https://github.com/socialappslab/appcivist-pb-client.git

WORKDIR ${PROJECT_HOME}
EXPOSE 8000
ADD deploy.sh deploy.sh
RUN ./deploy.sh
CMD sudo apachectl -D FOREGROUND