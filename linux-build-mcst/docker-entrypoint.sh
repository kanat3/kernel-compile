#!/bin/bash

dir=/usr/src/kernel-source

extract_dir=$dir/build-docker

build_dir=$dir/build-docker/kernel-build

if [[ ! -d "$build_dir" ]]; then
  mkdir "$build_dir"
fi

file=$(find "$extract_dir" -type f -name "*.tar.gz" -print -quit)

if [[ -z $file ]]; then
  echo "Can't find *.gz in extract_dir. Please download file from https://kernel.org"
  exit 1
fi

tar -xvf "$file" -C "$build_dir"

if [[ ! $? -eq 0 ]]; then
  echo "Unzip error"
  exit 1
fi

cd $build_dir/linux*

START=$(date +%s)

if $IS_MENUCONFIG; then
  make menuconfig; else 
  make defconfig;
fi

make -j$(nproc)

END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Kernel compilation end in $DIFF s"