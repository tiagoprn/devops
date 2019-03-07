#!/bin/bash

DEVELOPMENT="development";
PRODUCTION="production";

echo "Please choose an environment: "
echo "1 - DEVELOPMENT"
echo "2 - PRODUCTION"
read n
case $n in
    1) REDIS_INSTANCE="redis.local" && ENVIRONMENT="$DEVELOPMENT";;
    2) REDIS_INSTANCE="redis.production" && ENVIRONMENT="$PRODUCTION";;
    *) echo "Choose between 1 and 2. Quitting..." && exit;;
esac

echo "Will run redis on url $REDIS_INSTANCE on environment $ENVIRONMENT."
