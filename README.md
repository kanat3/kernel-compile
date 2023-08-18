# kernel compilation

Compiled kernel files can be found here: *...kernel_build/build-docker*

### Arguments:

LINUX_KERNEL_SOURCES - the path for archive with linux kernel sources

ABSOLUTE_SOURCE_PATH - the absolute path for archive with linux kernel sources (need for using tmpfs mount)

TZ - timezone

IS_MENUCONFIG - variable to select the configuration method. In the case true, you use make menuconfig  and need to connect to the container (steps 4-5) and set the parameters manually. If the case false, compilation will happen automatically (the last step - 3)

The root of the directory is the folder containing the Dockerfile

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

### Improvement:

If you have a good hardware, then you can use it to speed up the build of the kernel in the container. To do this, mount a volume of the tmpfs type in the docker-compose file as in the example.
```
volumes:
    - type: tmpfs
    target: ${ABSOLUTE_SOURCE_PATH}:/usr/src/kernel-source
    tmpfs:
        size: 8192
        mode: 755
```
Set the desired size (tmpfs-size) and access rights (tmpfs-mode). And also specify the source folder to copy them directly to RAM like this:
```
target: absolute_path_for_sorces:path_in_the_container
```
Don't forget to return the used memory to the heap by deleting the executed container.

