FROM openjdk:8
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-platform

# Create editor userspace
RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install -y sudo vim
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PROJECT_HOME}
RUN mkdir -p /opt/appcivist/files
RUN chown appcivist:appcivist /opt/appcivist/files
RUN chown appcivist:appcivist ${PROJECT_HOME}
ADD deploy.sh deploy.sh
RUN chmod 777 deploy.sh
USER appcivist
EXPOSE 9000
EXPOSE 8888
EXPOSE 9999
CMD sh deploy.sh
