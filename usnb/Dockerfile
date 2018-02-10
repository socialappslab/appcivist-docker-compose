FROM node:6
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_DIR /home/appcivist/production/usnb


RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

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
RUN mkdir -p ${PROJECT_DIR}
RUN mkdir ${PROJECT_DIR}/api-gateway
RUN mkdir ${PROJECT_DIR}/email-bindingcomponent
RUN mkdir ${PROJECT_DIR}/entity-manager
RUN mkdir ${PROJECT_DIR}/facebook-bindingcomponent
RUN mkdir ${PROJECT_DIR}/subscription-manager
RUN git clone https://github.com/socialappslab/usnb ${PROJECT_DIR}/usnb
COPY deploy_local ${PROJECT_DIR}/usnb/deploy_local
RUN chown -R appcivist:appcivist ${PROJECT_DIR}
RUN chmod 777 ${PROJECT_DIR}/usnb/deploy_local/deploy.sh
WORKDIR ${PROJECT_DIR}/usnb/deploy_local
USER appcivist
