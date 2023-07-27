# kernel cross-compilation
##### Arguments:
#
###### LINUX_KERNEL_SOURCES -- the path for archive with linux kernel sources
#
###### TZ -- timezone
#
###### The root of the directory is the folder containing the .sh file
#
##### Usage docker-compose.yml:
###### 1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile.
#
###### 2. Set arguments in .env file. Don't change COMPOSE_CONFIG value.
#
###### 3. Just use this
```
bash up.sh
```
#
##### Usage only Dockerfile:
#
###### 1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile.
#
###### 2. Create docker image
```
docker build --build-arg LINUX_KERNEL_SOURCES=your_path_to_source_code --tag 'kernel_build_img:latest' .
```
###### 3. Create docker container
```
docker run --name kernel_build -it kernel_build_img /bin/bash
```