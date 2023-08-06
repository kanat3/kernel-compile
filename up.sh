#!/bin/bash

container_id=$(docker ps -aqf name=linux-build-mcst)

if [[ -n "$container_id" ]]; then
    if [ "$( docker container inspect -f '{{.State.Running}}' $container_id )" = "true" ]; then
        docker stop $container_id
    fi
    docker rm -f $container_id
fi

set -a
source .env
cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "linux-build-mcst" up -d

# can be new after stop/rm
container_id=$(docker ps -aqf name=linux-build-mcst)

docker logs -f $container_id &> output.log &

build_dir=$(pwd)/build-docker

if [[ -d "$build_dir" ]]; then
  rm -rf $build_dir
fi

echo "Waiting for data..."

docker wait $container_id

docker cp -a $container_id:/usr/src/kernel-source/build-docker $(pwd)/build-docker