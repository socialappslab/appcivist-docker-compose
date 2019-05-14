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

### Configuring Apache

Default configuration files are available in the `apache/confs` folders. Domain names, redirections and a file server are all configured by these configuration files. By default, they have the original configuration of the prototype appcivist service instance, but you should absolutely modify them to your needs. Having a better organized boiler plate for this confs has been on our TODO list for a while. 

For SSL, make sure sites are by default configured to use SSL certificates that sit on the `apache/certs` folder, mounted as `/etc/apache2/certs` in the container. Make sure that, if you do not have SSL certificates, comment all the lines that attempt to configure vhosts for it in the conf file, otherwise apache will not run. If you do have cert files, copy them to `apache/certs` and then update the links in the configurations. As an option, our Dockerfile for apache installs (`certbo-auto`)[https://certbot.eff.org/lets-encrypt/debianjessie-apache], which you can use to easily issue and install [Let's Encrypt](https://letsencrypt.org/) certificates. All you have to do is running the following, selecting properly the domains for which you would like to create certificates:

```sh
/usr/local/bin/certbot-auto --apache certonly
```

After the certificate is created and available somewhere in the container, you can change configurations to use them. 

Finally, the `apache/confs` folder is mounted as a volume inside of the apache container, becoming effectively the `/etc/apache2/sites-available` within the container. What this means is that after building the apache container, you will have to enter that container and add each site configuration using the `a2ensite`. 
```sh
# Run this after the apache has been build and is running
$ docker exec -t -i apache /bin/bash
$ cd /etc/apache2/sites-available
$ a2ensite *.conf
$ service apache reload
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
