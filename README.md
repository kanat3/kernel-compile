# kernel cross-compilation
### Arguments:

LINUX_KERNEL_SOURCES - the path for archive with linux kernel sources

TZ - timezone

The root of the directory is the folder containing the Docker file

### Usage docker-compose.yml:

1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile

2. Set arguments in .env file. Don't change COMPOSE_CONFIG value

3. Just use this
```
bash up.sh
```
4. Connect to the container and edit .config
```
docker exec -it linux-build-mcst /bin/bash
```
5. Compile the kernel
```
make menuconfig
make -j$(nproc)
```
### Usage only Dockerfile:

1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile

2. Create docker image
```
docker build --build-arg LINUX_KERNEL_SOURCES=your_path_to_source_code --tag 'kernel_build_img:latest' .
```
1. Create docker container
```
docker run --name kernel_build -it kernel_build_img /bin/bash
```