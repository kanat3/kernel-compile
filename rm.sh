#!/bin/bash

container_id=$(docker ps -aqf "name=linux-build-mcst")
image_i=$(docker images | grep "linux-build-mcst")

if [[ -z "$container_id" ]]; then
    echo "No such container id"
    exit 1
fi

docker stop $container_id 

docker rm $container_id

if [[ -z "$image_id" ]]; then
    echo "No such image id"
    exit 1
fi

docker rmi $image_id