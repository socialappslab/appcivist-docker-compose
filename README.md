# appcivist-docker-compose
AppCivist multi-container docker composer. This includes: `appcivist-backend, appcivist-voting-api, appcivist-pb-client, etherpad-lite, socialbus components`

# Installation Steps

### Install docker:
```sh
$ sudo apt-get install docker
```

### Install docker-compose
```sh
$ sudo pip install docker-compose
```

### install git
```sh
$ sudo apt-get install git
```

### Create non-root sudoer user and add to docker group
```sh
$ useradd -m -c "AppCivist" ${USER}t -s /bin/bash
$ sudo usermod -aG docker ${USER}
```

### OPTIONAL: add user to sudoers group if you also want to perform other admin tasks with this user 
```sh
$ usermod -aG sudo username`
```

### change to the new non-root user
```sh
$ su ${USER}
```

### go to the user’s home
```sh
$ cd /path/to/home
$ mkdir production
$ cd production
```
### Clone platform, voting and PB UI code from github
```sh
$ git clone https://github.com/socialappslab/appcivist-platform.git
$ chmod -R 777 appcivist-platform 
$ git clone https://github.com/socialappslab/appcivist-pb-client.git
$ $ chmod -R 777 appcivist-pb-client
$ git clone https://github.com/socialappslab/appcivist-voting-api.git
$ chmod -R 777 appcivist-voting-api
```

### Prepare and configure Universal Social Bus 
```sh
$ mkdir usnb
$ cd usnb
$ git clone https://github.com/socialappslab/usnb.git
```

### Create directories for usnb projects
```
$ mkdir api-gateway email-bindingcomponent entity-manager facebook-bindingcomponent subscription-manager
```
 
### Create deployment directory
```sh
$ cd ..
$ git clone https://github.com/socialappslab/appcivist-docker-compose.git
$ cd appcivist-docker-compose
### Make a copy of .env.sample file named .env and set the users and password for all the systems
$ cp .env.sample .env
$ nano .env
```

### Configure appcivist-frontend/sites for apache vhost, edit the .conf files
```sh
$ cd appcivist-frontend/site
```

### Edit the .conf files 

### make a copy of the ssl certificate inside the /appcivist-docker-compose/appcivist-frontend/ssll directory.  
```sh
$ mkdir ssll
$ cd ssll
$ scp appcivist@104.131.157.72:/home/appcivist/ssl/ssl.zip ssl.zip
$ unzip ssl.zip
$ rm ssl.zip
```

### The first time that we deploy all, first we need to build and up the postgres db container with:
```sh 
$ cd ..
$ cd ..
$ docker-compose build db && docker-compose up -d db
```

### With the postgres up and with the appcivist and etherpads db backups files already in the server, make the restore with:
```
$ docker cp 20180312_appcivist db:/tmp
$ docker cp 20180312_etherpad_appcivist db:/tmp
```

### and make the restore in the db with
```sh
$ docker exec -t -i db /bin/bash 
$ psql -U appcivist appcivist < /tmp/20180312_appcivist
```

### create etherpad database
```sh
$ psql -U appcivist appcivist
$ create database “20180312_etherpad_appcivist”;
$ \q
```

### restore etherpad database
```sh
$ psql -U appcivist 20180312_etherpad_appcivist < /tmp/20180312_etherpad_appcivist
$ exit
```
 
### Then, we can build and up the mongo db with:
```sh
$ docker-compose build mongo && docker-compose up -d mongo
```

### With the mongo up and with the mongodump db backups files already in the server, make the restore with:
```sh
$ docker cp /tmp/20180324_mongo/ mongo:/tmp/20180324_mongo/
$ docker exec mongo mongorestore /tmp/20180324_mongo/
```

### Deploy all
```sh
$ sh deploy_all.sh
```
 
### View the up services with
`$ docker ps` 
### View the logs with
`$ docker-compose logs`

### Stop a service with
`$ docker-compose stop {container_name}`
