FROM postgres:9.4.5
RUN apt-get update && apt-get install -y pgagent
COPY postgres.conf /etc/postgresql/postgresql.conf
