# kernel cross-compilation
##### Arguments:
#
###### LINUX_KERNEL_SOURCES -- the path for archive with linux kernel sources
###### The root of the directory is the folder containing the .sh file
#
##### Usage:
#
###### 1. Download file from https://www.kernel.org/
#
###### 2. Create docker image
```
docker build --build-arg LINUX_KERNEL_SOURCES=your_path_to_source_code --tag 'kernel_build_img:latest' .
```
###### 3. Create docker container
```
docker run --name kernel_build -it kernel_build_img /bin/bash
```