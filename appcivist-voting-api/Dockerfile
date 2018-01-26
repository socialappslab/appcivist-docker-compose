FROM ruby:2.2.3
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-voting-api
ENV DB_PASS $VOTING_API_DB_PASS
ENV DB_USER $VOTING_API_DB_USER
ENV DB_USER $VOTING_API_SECRET

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update
RUN apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN gem install rails -v 4.2.5
ADD appcivist-voting-api.sh /etc/init.d/appcivist-voting-api.sh
ADD deploy.sh deploy.sh
EXPOSE 5000
USER appcivist


