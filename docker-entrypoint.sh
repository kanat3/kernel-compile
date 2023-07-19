#!/bin/bash

extract_dir=/usr/src/kernel-source

build_dir=/usr/src/kernel-source/build-docker

# Проверяем наличие директории "build-docker" или создаем ее
if [[ ! -d "$build_dir" ]]; then
  mkdir "$build_dir"
fi

# Ищем файл типа tar.gz в указанном каталоге
file=$(find "$extract_dir" -type f -name "*.tar.gz" -print -quit)

echo $file

echo $build_dir

# Убеждаемся, что найден файл для распаковки
if [[ -z $file ]]; then
  echo "Не найден файл *.gz в текущем каталоге"
  exit 1
fi

# Распаковываем файл в каталог build-docker
tar -xvf "$file" -C "$build_dir"

# Проверяем результат выполнения команды tar
if [[ $? -eq 0 ]]; then
  echo "Файл успешно распакован в каталог: $build_dir"
else
  echo "Произошла ошибка при распаковке файла"
  exit 1
fi

cd $build_dir/linux*

echo "We are in the linux-kernel dir"

make menuconfig

make -j$(nproc)

make modules_install

make install
