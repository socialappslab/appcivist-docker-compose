FROM digitallyseamless/nodejs-bower-grunt
MAINTAINER Cristhian Parra <cdparra@gmail.com>

RUN groupadd appcivist
RUN useradd appcivist -m -g appcivist -s /bin/bash
RUN passwd -d -u appcivist
RUN apt-get update && apt-get install sudo
RUN echo "appcivist ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/appcivist
RUN chmod 0440 /etc/sudoers.d/appcivist

RUN mkdir -p /opt/appcivist/files
RUN mkdir -p /etc/apache2/certs
RUN chown appcivist:appcivist /opt/appcivist/files
RUN chmod 777 -R /opt/appcivist/files/
RUN apt-get install -y apache2 nano
RUN a2enmod ssl
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod headers
RUN service apache2 restart
EXPOSE 8081
EXPOSE 443
EXPOSE 4444
EXPOSE 9000
EXPOSE 8888
EXPOSE 80
EXPOSE 9001

# Installing certbot-auto to generate letsencrypt certificates
RUN wget https://dl.eff.org/certbot-auto
RUN mv certbot-auto /usr/local/bin/certbot-auto
RUN chown root /usr/local/bin/certbot-auto
RUN chmod 0755 /usr/local/bin/certbot-auto
CMD apachectl -k restart -D FOREGROUND
