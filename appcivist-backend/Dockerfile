FROM openjdk:8
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/appcivist/production/appcivist-platform

# Create editor userspace
RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PROJECT_HOME}
RUN chown appcivist:appcivist ${PROJECT_HOME}
USER appcivist
#Add init script
ADD appcivist-backend /etc/init.d/appcivist-backend

# Expose play ports 9000 default 9999 debug 8888 activator ui
EXPOSE 9000
EXPOSE 9999
EXPOSE 8888
#build the project and start it
WORKDIR  ${PROJECT_HOME}