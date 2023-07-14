FROM debian:bookwarm

# default value for env
ENV SOURCE_DIR=source

COPY ${SOURCE_DIR} /usr/src/kernel-source

WORKDIR /usr/src/kernel-source

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
