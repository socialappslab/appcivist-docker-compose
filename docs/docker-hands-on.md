
# Check you have Docker installed

    docker --version

If not installed, you can run the apt command below.

    sudo apt install docker.io

Wait until the installation has been completed, then you can start Docker and add it to the boot time with the systemctl command:

    systemctl start docker
    systemctl enable docker
    systemctl restart docker
    service restart docker
    /etc/init.d/docker restart

Run the version command again: 
    
    docker --version

# Login to docker

First create your user/password in https://hub.docker.com

    docker login

# Create and build a docker image

    cd [YOUR_WORKSPACE_DIRECTORY]
    mkdir flipp-docker-tutorial
    cd flipp-docker-tutorial

Open a text file to create the `Dockerfile
Include a base image with `FROM` command. Choose the image from the hub registry. e.g., `8.12.0-jessie`. First part is version of app and second part is version of linux

    docker build .
    docker images

To add tag to the image
    
    docker build . -t flipp-node:latest


# Run the image
    docker run [IMAGE ID]

Will stop because there is no command in the docker file. No process. 
Let's run a process. 

    docker run -it [IMAGE ID] /bin/sh

List of processes
    
    docker ps


# Let's create a simple Node App

## Develop the app

    vim server.js

    var http = require('http');
    
    http.createServer(function (req, res) {
        res.write('Hello World!');
        res.end();
    }).listen(8000);

*Observation:* Try to always have your local development environment to match the environment in your containers. 

## Add commands to the Dockerfile to run the app

    vim Dockerfile

    FROM node:10.12.0-alpine
    
    WORKDIR /app
    
    ADD . /app 

## Rebuild the docker image

    docker build . -t flipp-node:latest
    docker images

The docker IMAGE ID will now change (no longer same as node image)

## Run the image and server

    docker run -it flipp-node /bin/sh
    /app # node server.js

or better

    docker run -it flipp-node node server.js

Para parar proceso: 
1. Detach 
    
    CTRL pq
2. 

CTRL pq to detach from the container shell. Then docker stop to kill the container. 

    docker ps
    docker stop [CONTAINER ID]

Because docker works on a virtual private network, we need to map the docker container port to a local port.  

    docker run -p 8001:8000 -it flipp-node node server.js

We are mapping the local machine 8001 port to the 8000 port of the container. 

We can also run the command directly in the Dockerfile

    FROM node:10.12.0-alpine
    WORKDIR /app
    ADD . /app 
    CMD ["node","server.js"]

    docker build . -t flipp-node:latest
    docker run -d -p 8001:8000 

The -d flag puts the process of the container in the background.

## Running other commands while building
We can also run commands from the Dockerfile using `RUN`. 
   
    vim run.sh

    #!/bin/sh
    node server.js

    vim Dockerfile

    FROM node:10.12.0-alpine
    WORKDIR /app
    ADD . /app
    RUN chmod +x ./run.sh
    CMD ["./run.sh"]

For example, you can install `vim`, an editor that is very useful to debug the contents of an image. 

    FROM node:10.12.0-apline
    WORKDIR /app
    ADD . /app 
    RUN apk add vim
    CMD ["node","server.js"]

    docker build . -t flipp-node:latest
    

Docker builds intermediate images. So if the building of a Dockerfile fails, you can access the intermediary image to figure out what's happening. 

    Sending build context to Docker daemon  3.072kB
    Step 1/5 : FROM node:10.12.0-alpine
     ---> 7ca2f9cb5536
    Step 2/5 : WORKDIR /app
     ---> Using cache
     ---> e5338356842d
    Step 3/5 : ADD . /app
     ---> aaa076117d32
    Step 4/5 : CMD ["node","server.js"]
     ---> Running in f26752613a26
    Removing intermediate container f26752613a26
     ---> dde2e5ea9684
    Step 5/5 : RUN apk add vim
     ---> Running in 405af7e3550c
    fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
    fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
    (1/5) Installing lua5.3-libs (5.3.4-r5)
    (2/5) Installing ncurses-terminfo-base (6.1_p20180818-r1)
    (3/5) Installing ncurses-terminfo (6.1_p20180818-r1)
    (4/5) Installing ncurses-libs (6.1_p20180818-r1)
    (5/5) Installing vim (8.1.0115-r0)
    Executing busybox-1.28.4-r1.trigger
    OK: 40 MiB in 20 packages
    Removing intermediate container 405af7e3550c
     ---> c9160fb4f17b
    Successfully built c9160fb4f17b
    Successfully tagged flipp-node:latest


    docker run -it dde2e5ea9684 /bin/sh

## Ejercicio
1. Crea un Dockerfile que use como base etherpad-lite
1. Para eso, busca en el Hub de Docker una imagen del editor 
colaborativo etherpad-lite
2. Edita el Dockerfile y asegurate que se instale también el 
comando `abiword` en el container

## Docker compose
    
    mkdir docker-compose-tutorial
    mkdir data
    mkdir postgres
    mkdir etherpad-lite

    vim etherpad-lite/Dockerfile

    FROM tvelocity/etherpad-lite
    RUN apt-get update
    RUN apt-get install -y abiword
    RUN echo "www-data ALL = NOPASSWD: /usr/bin/abiword" > /etc/sudoers
    RUN npm cache clean -f
    RUN npm install -g n
    RUN n stable

The lasts commands are to update node to the latest version, so that etherpad works correclty. 


    vim postgres/Dockerfile

    FROM postgres:11-alpine

    vim postgres/postgres.conf

    listen_addresses = '*'


    vim .env

    ETHERPAD_DB_TYPE=postgres
    ETHERPAD_DB_HOST=localhost
    ETHERPAD_DB_USER=postgres
    ETHERPAD_DB_PASSWORD=postgres
    ETHERPAD_DB_NAME=etherpad_appcivist
    POSTGRES_PASSWORD=postgres
    POSTGRES_USER=postgres

docker-compose.yml


    db:
      build: ./postgres
      environment:
      - POSTGRES_PASSWORD
      - POSTGRES_USER
      - POSTGRES_DB
      volumes:
      - ./postgres/postgres.conf:/etc/postgresql/postgresql.conf
      - ./data:/var/lib/postgresql/data
      net: "host"
      container_name: db

    etherpad-lite:
      build: ./etherpad-lite
      ports:
        - "9001:9001"
      net: "host"
      environment:
      - ETHERPAD_DB_TYPE
      - ETHERPAD_DB_HOST
      - ETHERPAD_DB_USER
      - ETHERPAD_DB_PASSWORD
      - ETHERPAD_DB_NAME
      container_name: etherpad-lite


# Homework

1. Buscar y seguir tutoriales sobre docker-compose
2. Probar ejecutar el docker-compose de AppCivist
    - Descargar docker-compose de AppCivist: https://github.com/socialappslab/appcivist-docker-compose
    - Ejecutar `docker-compose build`
    - Ejecutar `docker-compose up`
    - Documentar problemas

## AppCivist Testing (for next Sesion)
1. Download testing database: `https://files.appcivist.org/uploads/20181015_appcivist_postgres_NO_LOG.sql` 
2. Create database `20181015_appcivist_postgres`
3. Restore: `psql -d 20181015_appcivist < 20180716_appcivist_postgres.sql`

