#!/bin/bash
APPCIVIST_HOME="/home/appcivist/production"
PLATFORM_LOGS="$APPCIVIST_HOME/appcivist-platform/target/universal/stage/logs/application.log"
FRONTEND_LOGS="$APPCIVIST_HOME/appcivist-pb-client/app.log"
VOTING_LOGS="$APPCIVIST_HOME/appcivist-voting-api/app.log"
tail -f $PLATFORM_LOGS $FRONTEND_LOGS $VOTING_LOGS
docker logs etherpad-lite
