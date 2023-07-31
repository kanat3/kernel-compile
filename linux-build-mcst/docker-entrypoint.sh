#!/bin/bash

extract_dir=/usr/src/kernel-source

build_dir=/usr/src/kernel-source/build-docker

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

if $IS_MENUCONFIG; then
  make menuconfig; else 
  make defconfig;
fi

make -j$(nproc)