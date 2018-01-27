FROM openjdk:8
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PROJECT_HOME /home/etherpad/etherpad-lite

# Create editor userspace
RUN groupadd etherpad
RUN useradd etherpad -m -g etherpad -s /bin/bash
RUN passwd -d -u etherpad
RUN apt-get update && apt-get install -y sudo gzip git curl python libssl-dev pkg-config build-essential
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - && apt-get install -y nodejs
RUN echo "etherpad ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/etherpad
RUN chmod 0440 /etc/sudoers.d/etherpad
RUN mkdir -p ${PROJECT_HOME} && mkdir -p /var/log/etherpad-lite/ && touch /var/log/etherpad-lite/etherpad-lite.log && \
    chown etherpad:etherpad ${PROJECT_HOME} && chown etherpad:etherpad /var/log/etherpad-lite/etherpad-lite.log && \
    chown etherpad:etherpad /var/run
EXPOSE 9001
USER etherpad
#Add init script
ADD etherpad-lite /etc/init.d/etherpad-lite
#build the project and start it
WORKDIR  ${PROJECT_HOME}