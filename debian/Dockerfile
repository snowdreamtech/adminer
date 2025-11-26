FROM snowdreamtech/php:8.4.11-fpm-trixie

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminer Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Adminer on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminer" \
    org.opencontainers.image.base.name="snowdreamtech/adminer:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminer" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="5.3.0" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/adminer"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ARG DEBIAN_FRONTEND=noninteractive \
    KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 \
    # Ensure the container exec commands handle range of utf8 characters based of
    # default locales in base image (https://github.com/docker-library/docs/tree/master/debian#locales)
    LANG=C.UTF-8\
    UMASK=022 \
    DEBUG=false \
    PGID=0 \
    PUID=0  \
    USER=root \
    WORKDIR=/root 

ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    # keep the docker container running
    KEEPALIVE=${KEEPALIVE} \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    # Ensure the container exec commands handle range of utf8 characters based of
    # default locales in base image (https://github.com/docker-library/docs/tree/master/debian#locales)
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PGID=${PGID} \
    PUID=${PUID}  \
    USER=${USER} \
    WORKDIR=${WORKDIR} 

ENV ADMINER_VERSION=5.3.0 \
    ADMINER_SQLITE_PASSWORD='' \
    ADMINER_PATH=/usr/share/nginx/html \
    ADMINER_THEMES_PATH=/usr/share/nginx/html/designs \
    ADMINER_PLUGINS_PATH=/usr/share/nginx/html/adminer-plugins \
    GITHUB_PROXY=

# Create a user with PUID and PGID
RUN if [ "${USER}" != "root" ] && [ ! -d "/home/${USER}" ] && [ "${PUID}" -ne 0 ] && [ "${PGID}" -ne 0 ]; then \
    addgroup --gid ${PGID} ${USER}; \
    adduser --home /home/${USER} --uid ${PUID} --gid ${PGID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi
    
RUN mkdir -p ${ADMINER_PATH} \
    && mkdir -p ${ADMINER_THEMES_PATH} \
    && mkdir -p ${ADMINER_PLUGINS_PATH} \
    && rm -rfv ${ADMINER_PATH}/* \
    && wget ${GITHUB_PROXY}https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O ${ADMINER_PATH}/index.php \
    && wget ${GITHUB_PROXY}https://github.com/vrana/adminer/archive/refs/tags/v${ADMINER_VERSION}.tar.gz -O adminer.tar.gz \
    && tar -xzvf adminer.tar.gz \
    && cp -rfv adminer-${ADMINER_VERSION}/designs ${ADMINER_THEMES_PATH}/ \
    && cp -rfv adminer-${ADMINER_VERSION}/plugins ${ADMINER_PLUGINS_PATH}/ \
    && rm -rfv adminer-${ADMINER_VERSION} adminer.tar.gz

# Enable CAP_NET_BIND_SERVICE
# RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
#     # setcap 'cap_net_bind_service=+ep' `which nginx`; \
#     fi

COPY entrypoint.d /usr/local/bin/entrypoint.d

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.d/*

ENTRYPOINT ["docker-entrypoint.sh"]