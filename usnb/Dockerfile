FROM node:latest
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/usnb/usnb

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
RUN apt-get install -y git
RUN npm install pm2@latest -g
#USNB_API_GATEWAY_PORT
EXPOSE 3025
#USNB_EMAIL_PERSONA_PORT
EXPOSE 3026
#USNB_ENTITY_MANAGER_PORT
EXPOSE 3024
#USNB_FACEBOOK_PERSONA_PORT
EXPOSE 3027
#USNB_NOTIFICATIONS_PORT
EXPOSE 3023
USER appcvist
WORKDIR ${PROJECT_HOME}/deploy
