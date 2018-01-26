#!/bin/sh 
CMD="/usr/local/bin/rails"
CMD_ARGS='server -p 5000'
APP_DIR='/home/appcivist/production/appcivist-voting-api';
PID_FILE=$APP_DIR/app.pid
LOG_FILE=$APP_DIR/app.log

###############

# REDHAT chkconfig header

# chkconfig: - 58 74
# description: node-app is the script for starting a node app on boot.
### BEGIN INIT INFO
# Provides: node
# Required-Start:    $network $remote_fs $local_fs
# Required-Stop:     $network $remote_fs $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: start and stop node
# Description: Node process for app
### END INIT INFO

set -e

. /lib/lsb/init-functions

start_app (){
    export SECRET_KEY_BASE=ae6e041df2fdc3e70682a521af1e2bb46f2085f98033d17729d5b6232d8e7a724c54087f4b396b8763c2f12c4af7a28b8763f05c12a8949685fc4613c88bb10a
    export DATABASE_URL="postgresql://appcivist:.21.c-84.dpt.@localhost:5432/appcivist"
    export RAILS_ENV=production
    export HOME=$APP_DIR
    if [ -f $PID_FILE ]
    then
        echo "$PID_FILE exists, process is already running or crashed"
        exit 1
    else
        echo "Starting rails app..."
	start-stop-daemon -v --start --chuid "$USER:$GROUP" --pidfile $PID_FILE -d $APP_DIR --exec $CMD -- $CMD_ARGS 1>$LOG_FILE 2>$LOG_FILE
    fi
}

stop_app (){
    if [ ! -f $PID_FILE ]
    then
        echo "$PID_FILE does not exist, process is not running"
        exit 1
    else
        echo "Stopping $APP_DIR/$NODE_APP $CMD ..."
        echo "Killing `cat $PID_FILE`"
        kill `cat $PID_FILE`;
        rm -f $PID_FILE;
        echo "Node stopped"
    fi
}

#We need this function to ensure the whole process tree will be killed
killtree() {
    local _pid=$1
    local _sig=${2-TERM}
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -${_sig} ${_pid}
}

status() {
  status_of_proc -p $PID_FILE "" "appcivist-voting-api" && exit 0 || exit $?
}

case "$1" in
    start)
        start_app
    ;;

    stop)
        stop_app
    ;;

    restart)
        stop_app
        start_app
    ;;

    status)
	status
    ;;

    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
    ;;
esac
