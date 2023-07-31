FROM debian:bookworm


ARG LINUX_KERNEL_SOURCES=local
ENV LINUX_KERNEL_SOURCES=${LINUX_KERNEL_SOURCES}

ARG IS_MENUCONFIG=true
ENV IS_MENUCONFIG=${IS_MENUCONFIG}

COPY ${LINUX_KERNEL_SOURCES} /usr/src/kernel-source

WORKDIR /usr/src/kernel-source

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends\
    build-essential \
    libncurses-dev \
    bison flex \
    libssl-dev \
    libelf-dev \
    bc \
    kmod


RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
