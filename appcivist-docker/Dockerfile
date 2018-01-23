FROM ubuntu:14.04
MAINTAINER Cristhian Parra <cdparra@gmail.com>
ENV PRODUCTION_HOME /home/appcivist/production
ENV PROJECT_HOME /home/appcivist/production/appcivist-platform

# Create editor userspace
RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist
RUN mkdir -p ${PRODUCTION_HOME}



# Install dependencies
RUN apt-get update && \
    apt-get install -y git build-essential curl wget zip unzip software-properties-common


## Install Oracle's JDK
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
RUN tar -zxvf jdk-8u*-linux-*.tar.gz
RUN mv jdk1.8.*/ /usr/
RUN update-alternatives --install /usr/bin/java java /usr/jdk1.8.*/bin/java 2
RUN update-alternatives --config java
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN chown appcivist:appcivist ${PRODUCTION_HOME}
USER appcivist
WORKDIR ${PRODUCTION_HOME}
#clone the project, set permissions and get the last changes
RUN git clone https://github.com/socialappslab/appcivist-platform.git

WORKDIR ${PROJECT_HOME}
RUN git pull

# Define user home. Activator will store ivy2 and sbt caches on ${PROJECT_HOME} volume
RUN echo "export _JAVA_OPTIONS='-Duser.home=${PROJECT_HOME}'" >> /home/appcivist/.bashrc

#Add init script
ADD appcivist-backend /etc/init.d/appcivist-backend

WORKDIR /home/appcivist

# Expose play ports 9000 default 9999 debug 8888 activator ui
EXPOSE 9000
EXPOSE 9999
EXPOSE 8888

#build the project and start it
WORKDIR ${PROJECT_HOME}
RUN ./activator stage 
CMD /etc/init.d/appcivist-backend restart
