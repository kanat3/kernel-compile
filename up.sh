#!/bin/bash

result=$(docker ps -aq -f name=linux-build-mcst_*)

if [[ -n "$result" ]]; then
    docker rm -f $(docker ps -aq -f name=linux-build-mcst_*)
fi

set -a
source .env
cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "linux-build-mcst" up -d

docker logs -f $(docker ps -aqf "name=linux-build-mcst") &> output.log &