# kernel cross-compilation
### Arguments:

LINUX_KERNEL_SOURCES - the path for archive with linux kernel sources

TZ - timezone

IS_MENUCONFIG - variable to select the configuration method. In the case true, you use make menuconfig  and need to connect to the container (steps 4-5) and set the parameters manually. If the case false, compilation will happen automatically (the last step - 3)

The root of the directory is the folder containing the Docker file

### Usage docker-compose.yml:

1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile

2. Set arguments in .env file. Don't change COMPOSE_CONFIG value

3. Just use this
```
bash up.sh
```
4. Connect to the container and edit .config (If IS_MENUCONFIG=true)
```
docker exec -it linux-build-mcst /bin/bash

make menuconfig
```
5. Compile the kernel (If IS_MENUCONFIG=true)
```
make -j$(nproc)
```
If you have changed something (espeially .env) then you also need to rebuild the image.
```
docker stop container_id | docker rm container_id

docker rmi image_id

bash up.sh #rebuilding
```
Or
```
bash rm.sh #deleting

bash up.sh
```

### Usage only Dockerfile:

1. Download *.gz file from https://www.kernel.org/ in directory near your Dockerfile

2. Create docker image
```
docker build --build-arg LINUX_KERNEL_SOURCES=your_path_to_source_code --tag 'kernel_build_img:latest' .
```
3. Create docker container
```
docker run --name kernel_build -it kernel_build_img /bin/bash
```

### Logs:
```
cat output.log
```