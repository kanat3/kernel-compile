#!/bin/bash

extract_dir=""

# getting parameters
while getopts ":e:" opt; do
  case $opt in
    e)
      extract_dir=$OPTARG
      ;;
    ?)
      echo "Неверный флаг: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Убеждаемся, что задан каталог для распаковки
if [[ -z $extract_dir ]]; then
  echo "Необходимо указать каталог для распаковки с помощью флага -e"
  exit 1
fi

build_dir="$extract_dir/build-docker"

# Проверяем наличие директории "build-docker" или создаем ее
if [[ ! -d "$build_dir" ]]; then
  mkdir "$build_dir"
fi

# Ищем файл типа tar.gz в указанном каталоге
file=$(find "$extract_dir" -type f -name "*.tar.gz" -print -quit)

# Убеждаемся, что найден файл для распаковки
if [[ -z $file ]]; then
  echo "Не найден файл типа tar.gz в текущем каталоге"
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

# install referenses
# apt-get update && apt-get install -y build-essential libncurses-dev bison flex libssl-dev libelf-dev

# copy kernel settings
# zcat /proc/config.gz > .config
# make oldconfig

# or

# build kernel
# cd /usr/src/kernel-source
# cd "$build_dir"
# make menuconfig


# install kernel
# make -j$(nproc) && make modules

# sudo make install && sudo make modules_install
# grub-mkconfig -o /boot/grub/grub.cfg

# sudo reboot